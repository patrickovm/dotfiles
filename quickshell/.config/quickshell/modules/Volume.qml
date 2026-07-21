import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire
import "../"

Pill {
    id: root

    property Theme theme: Theme {}
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    readonly property int volumePct: sink && sink.audio ? Math.round(sink.audio.volume * 100) : 0

    color: theme.pulseaudio
    hPad: 8

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    Text {
        text: root.muted ? "󰖁 muted" : " " + root.volumePct + "%"
        color: theme.textDark
        font.family: theme.fontFamily
        font.pixelSize: theme.fontSize
    }

    overlay: MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                toggleMute.running = true
            } else if (mouse.button === Qt.MiddleButton) {
                pavucontrol.running = true
            }
        }
        onWheel: wheel => {
            if (!root.sink || !root.sink.audio) return
            const step = 0.05
            const delta = wheel.angleDelta.y > 0 ? step : -step
            root.sink.audio.volume = Math.max(0, Math.min(1.0, root.sink.audio.volume + delta))
        }
    }

    Process { id: toggleMute; command: ["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"] }
    Process { id: pavucontrol; command: ["pavucontrol"] }
}
