import QtQuick

QtObject {
    readonly property color bg: "#e6282a36"
    readonly property color fg: "#f8f8f2"
    readonly property color textDark: "#282a36"

    readonly property color network: "#8be9fd"
    readonly property color language: "#ff79c6"
    readonly property color workspacesBg: "#44475a"
    readonly property color workspaceOccupied: "#ffffff"
    readonly property color workspaceActive: "#50fa7b"
    readonly property color workspaceHover: "#8be9fd"
    readonly property color tray: "#6272a4"
    readonly property color pulseaudio: "#8be9fd"
    readonly property color cpu: "#50fa7b"
    readonly property color memory: "#ffb86c"
    readonly property color temperature: "#f1fa8c"
    readonly property color temperatureCritical: "#ff5555"
    readonly property color clock: "#bd93f9"

    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 15

    readonly property int pillRadius: 8
    readonly property int workspaceRadius: 10
    readonly property int barMargin: 6
    readonly property int gap: 4
}
