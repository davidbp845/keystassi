#Include ../utils/Debug.ahk

class HotkeyLoader {

    static debugMode := false

    static hotkeysConfig := Map(
        "toggleState", true,
        "exitApp", true,
        "moveUp", true,
        "moveLeft", true,
        "moveDown", true,
        "moveRight", true,
        "executeStep", true,
    )

    static hotkeys := Map()

    static load(path) {
        for hotkeyName, hotkeyLoad in HotkeyLoader.hotkeysConfig {
            if hotkeyLoad {
                hotkeyValue := IniRead(path, "hotkeys", hotkeyName, "")
                HotkeyLoader.hotkeys[hotkeyName] := hotkeyValue
                if HotkeyLoader.debugMode
                    UtilsDebug.Debug("HotkeyLoader load: " hotkeyName " " hotkeyValue)
            }
        }
    }

}