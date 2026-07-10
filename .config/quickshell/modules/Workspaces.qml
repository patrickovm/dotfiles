import QtQuick
import Quickshell.Hyprland
import "../"

Pill {
    id: root

    property Theme theme: Theme {}
    property HyprCompat hypr: HyprCompat {}

    color: theme.workspacesBg
    radius: theme.workspaceRadius
    hPad: 4
    vPad: 0

    Repeater {
        model: Hyprland.workspaces

        delegate: Text {
            id: wsLabel
            required property var modelData
            property bool hovered: false
            readonly property bool occupied:
                modelData.toplevels && modelData.toplevels.values.length > 0

            text: modelData.name
            topPadding: 5
            bottomPadding: 5
            leftPadding: 7
            rightPadding: 7
            font.family: theme.fontFamily
            font.pixelSize: theme.fontSize

            color: hovered ? theme.workspaceHover
                 : modelData.focused ? theme.workspaceActive
                 : occupied ? theme.workspaceOccupied
                 : theme.fg

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: wsLabel.hovered = true
                onExited: wsLabel.hovered = false
                onClicked: root.hypr.workspace(wsLabel.modelData.name)
            }
        }
    }
}
