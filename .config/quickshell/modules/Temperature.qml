import QtQuick
import Quickshell.Io
import "../"

Pill {
    id: root

    property Theme theme: Theme {}
    property string hwmonPath: "/sys/class/hwmon/hwmon1/temp1_input"
    property int criticalThreshold: 80
    property int tempC: 0

    readonly property bool critical: tempC >= criticalThreshold
    color: critical ? theme.temperatureCritical : theme.temperature
    hPad: 8

    Text {
        text: " " + root.tempC + "°C"
        color: theme.textDark
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
    }

    Process {
        id: proc
        command: ["sh", "-c", "cat '" + root.hwmonPath + "' 2>/dev/null"]
        stdout: SplitParser {
            onRead: data => {
                const v = parseInt(data.trim())
                if (!isNaN(v)) root.tempC = Math.round(v / 1000)
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
