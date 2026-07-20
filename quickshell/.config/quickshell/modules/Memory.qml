import QtQuick
import Quickshell.Io
import "../"

Pill {
    id: root

    property Theme theme: Theme {}
    property int usage: 0

    color: theme.memory
    hPad: 8

    Text {
        text: " " + root.usage + "%"
        color: theme.textDark
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
    }

    Process {
        id: proc
        command: ["sh", "-c", "free | awk '/Mem:/ {printf \"%.0f\", $3/$2*100}'"]
        stdout: SplitParser {
            onRead: data => {
                const v = parseInt(data.trim())
                if (!isNaN(v)) root.usage = v
            }
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: proc.running = true
    }
}
