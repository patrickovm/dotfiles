import QtQuick
import Quickshell.Hyprland

QtObject {
    readonly property bool luaDispatch: true

    function workspace(name) {
        if (luaDispatch) {
            const isNumeric = /^-?\d+$/.test(String(name))
            const arg = isNumeric ? name : ('"' + name + '"')
            Hyprland.dispatch("hl.dsp.focus({ workspace = " + arg + " })")
        } else {
            Hyprland.dispatch("workspace " + name)
        }
    }
}
