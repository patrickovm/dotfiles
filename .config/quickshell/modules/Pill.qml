import QtQuick

Rectangle {
    id: pill

    default property alias content: contentRow.data
    property alias overlay: overlayItem.data
    property alias spacing: contentRow.spacing

    property int hPad: 10
    property int vPad: 4

    radius: 8
    color: "transparent"

    implicitWidth: contentRow.implicitWidth + hPad * 2
    implicitHeight: contentRow.implicitHeight + vPad * 2

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 4
    }

    Item {
        id: overlayItem
        anchors.fill: parent
    }
}
