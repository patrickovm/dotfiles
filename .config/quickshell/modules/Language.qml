import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import "../"

Pill {
    id: root

    property Theme theme: Theme {}
    property string layout: "??"

    readonly property string shortLayout:
        layout.length >= 2 ? layout.substring(0, 2).toUpperCase() : layout.toUpperCase()

    color: theme.language
    hPad: 8

    Text {
        text: root.shortLayout
        color: theme.textDark
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
        font.bold: true
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                const parts = event.data.split(",")
                root.layout = parts[parts.length - 1]
            }
        }
    }

    function refresh() {
        pollProc.running = true
    }

    Process {
        id: pollProc
        command: ["sh", "-c",
            "hyprctl devices -j | grep -o '\"active_keymap\": *\"[^\"]*\"' | head -1 | sed -E 's/.*\"([^\"]+)\"$/\\1/'"]
        stdout: SplitParser {
            onRead: data => {
                const val = data.trim()
                if (val !== "") root.layout = val
            }
        }
    }

    Component.onCompleted: refresh()

    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }
}
