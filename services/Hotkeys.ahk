#Include ../utils/Debug.ahk

class HotkeyService {
    
    static hotkeys := Map()

    static AssignHotkey(key, func, states:=["all-Active"]) {
        if key != "" {
            Hotkey key, func, "Off"
            this.hotkeys[key] := states
        }
    }

    static ShowHotkeys() {
        for name, value in HotkeyService.hotkeys {
            UtilsDebug.Debug("Hotkey " name)
        }
    }

    static UpdateHotkeys(menuState) {
        menuIsActive := menuState.isMenuActive() ? "-Active" : "-Inactive"
        state := menuState.showState()
        for name, states in this.hotkeys {
            allowedStates := Map()
            if IsObject(states) {
                for state in states
                    allowedStates[state] := true
            }
            if (
                allowedStates.has(state) ||
                allowedStates.has("all") ||
                allowedStates.has("all" menuIsActive)
            ) {
                UtilsDebug.Debug("UpdateHotkeys " name " on")
                Hotkey name, "On"
            }
            else {
                UtilsDebug.Debug("UpdateHotkeys " name " off")
                Hotkey name, "Off"
            }
        }
    }
}