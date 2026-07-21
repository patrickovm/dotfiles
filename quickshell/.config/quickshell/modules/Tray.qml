import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import "../"

Pill {
    id: root
    property Theme theme: Theme {}
    color: theme.tray
    hPad: 8
    spacing: 6
    visible: trayRepeater.count > 0

    Repeater {
        id: trayRepeater
        model: SystemTray.items
        delegate: Image {
            id: trayIcon
            required property var modelData
            source: modelData.icon
            sourceSize.width: 18
            sourceSize.height: 18
            width: 18
            height: 18

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        trayIcon.modelData.activate()
                    } else if (mouse.button === Qt.MiddleButton) {
                        trayIcon.modelData.secondaryActivate()
                    } else if (mouse.button === Qt.RightButton) {
                        if (trayIcon.modelData.hasMenu) {
                            menuAnchor.open()
                        }
                    }
                }
            }

            QsMenuAnchor {
                id: menuAnchor
                menu: trayIcon.modelData.menu
                anchor.item: trayIcon
            }
        }
    }
}