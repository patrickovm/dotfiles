import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import "../"

Pill {
    id: root

    property Theme theme: Theme {}

    property string description: ""
    property string shortCode: "??"
    property string variant: ""
    property string keyboardName: "-------akko-keyboard"

    readonly property string displayText:
        variant.length > 0
            ? (shortCode + " " + variant).toUpperCase()
            : shortCode.toUpperCase()

    color: theme.language
    hPad: 8

    Text {
        text: root.displayText
        color: theme.textDark
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
        font.bold: true
    }

    function setDescription(desc) {
        root.description = desc
        const match = desc.match(/\(([^)]*)\)/)
        if (match) {
            const clauses = match[1].split(",").map(s => s.trim()).filter(s => s.length > 0)
            root.shortCode = clauses.length > 0 ? clauses[0] : desc.substring(0, 2)
            root.variant = clauses.slice(1).join(", ")
        } else {
            root.shortCode = desc.substring(0, 2)
            root.variant = ""
        }
    }


    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                const idx = event.data.indexOf(",")
                const devName = idx >= 0 ? event.data.substring(0, idx) : ""
                const desc = idx >= 0 ? event.data.substring(idx + 1) : event.data
                if (devName.trim() !== root.keyboardName) return  // ignore other devices
                root.setDescription(desc.trim())
            }
        }
    }

    function refresh() {
        pollProc.running = true
    }

    Process {
        id: pollProc
        command: ["sh", "-c",
            "hyprctl devices -j | jq -r '.keyboards[] | select(.name==\"" + root.keyboardName + "\") | .active_keymap'"]
        stdout: SplitParser {
            onRead: data => {
                const val = data.trim()
                if (val !== "") root.setDescription(val)
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
