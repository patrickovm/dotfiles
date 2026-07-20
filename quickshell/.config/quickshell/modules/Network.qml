import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "../"

Pill {
    id: root

    property Theme theme: Theme {}
    property string iface: ""
    property bool isWifi: false

    color: theme.network
    hPad: 8

    Text {
        text: root.iface === "" ? "" : (root.isWifi ? "" : "󰈀 " + root.iface)
        color: theme.textDark
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
    }

    overlay: MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        ToolTip.visible: containsMouse && root.iface !== ""
        ToolTip.text: root.iface
    }

    Process {
        id: routeProc
        command: ["sh", "-c", "ip route show default 2>/dev/null | awk '{print $5; exit}'"]
        stdout: SplitParser {
            onRead: data => {
                const name = data.trim()
                root.iface = name
                if (name === "") {
                    root.isWifi = false
                    return
                }
                wifiCheck.command = ["sh", "-c",
                    "test -d /sys/class/net/" + name + "/wireless && echo wifi || echo eth"]
                wifiCheck.running = true
            }
        }
    }

    Process {
        id: wifiCheck
        stdout: SplitParser {
            onRead: data => root.isWifi = data.trim() === "wifi"
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: routeProc.running = true
    }
}
