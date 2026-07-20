import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "./modules"
import "./"

PanelWindow {
    id: bar

    property Theme theme: Theme {}

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: 34
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Top

    Rectangle {
        anchors.fill: parent
        color: theme.bg
    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: theme.barMargin
        spacing: theme.gap

        Network {}
        Language {}
        Workspaces {}
    }

    WindowTitle {
        anchors.centerIn: parent
    }

    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: theme.barMargin
        spacing: theme.gap

        Tray {}
        Volume {}
        Cpu {}
        Memory {}
        Temperature {}
        Clock {}
    }
}
