import QtQuick
import Quickshell.Io
import "../"

Pill {
    id: root

    property Theme theme: Theme {}
    property int usage: 0
    property real lastIdle: -1
    property real lastTotal: -1

    color: theme.cpu
    hPad: 8

    Text {
        text: " " + root.usage + "%"
        color: theme.textDark
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
    }

    Process {
        id: proc
        command: ["sh", "-c", "head -n1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                const p = data.trim().split(/\s+/)
                const idle = (parseInt(p[4]) || 0) + (parseInt(p[5]) || 0)
                let total = 0
                for (let i = 1; i < p.length; i++) total += parseInt(p[i]) || 0

                if (root.lastTotal >= 0) {
                    const totalDelta = total - root.lastTotal
                    const idleDelta = idle - root.lastIdle
                    if (totalDelta > 0) {
                        root.usage = Math.round(100 * (totalDelta - idleDelta) / totalDelta)
                    }
                }
                root.lastIdle = idle
                root.lastTotal = total
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
