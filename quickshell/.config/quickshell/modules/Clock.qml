import QtQuick
import Quickshell.Io
import "../"

Pill {
    id: root

    property Theme theme: Theme {}
    property string timezone: "America/Fortaleza"
    property bool showShort: false
    property string timeText: ""

    color: theme.clock
    hPad: 8

    Text {
        text: root.timeText
        color: theme.textDark
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
    }

    overlay: MouseArea {
        anchors.fill: parent
        onClicked: root.showShort = !root.showShort
    }

    Process {
        id: proc
        command: ["sh", "-c",
            "TZ='" + root.timezone + "' date '" +
            (root.showShort ? "+%H:%M " : "+%A, %B %d, %Y (%H:%M) ") + "'"]
        stdout: SplitParser {
            onRead: data => root.timeText = data.trim()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: proc.running = true
    }
}
