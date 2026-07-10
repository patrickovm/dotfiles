import QtQuick
import Quickshell.Hyprland
import "../"

Item {
    id: root

    property Theme theme: Theme {}
    readonly property int maxLength: 60

    readonly property string rawTitle:
        Hyprland.activeToplevel ? Hyprland.activeToplevel.title : ""

    readonly property string displayTitle:
        rawTitle.length > maxLength ? rawTitle.substring(0, maxLength - 3) + "..." : rawTitle

    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    Text {
        id: label
        anchors.centerIn: parent
        text: root.displayTitle
        color: theme.fg
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
        elide: Text.ElideRight
    }
}
