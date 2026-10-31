#Requires AutoHotkey v2
#SingleInstance Force

SetTitleMatchMode(2)
DllCall("SetProcessDpiAwarenessContext", "ptr", -4) ; DPI per-monitor v2

#Include utils/Debug.ahk
#Include core/HotkeyLoader.ahk
#Include core/HUD.ahk
#Include core/MenuLoader.ahk
#Include core/MenuNode.ahk
#Include core/StateManager.ahk
#Include services/Hotkeys.ahk

; config.ini is local (not versioned): without it IniRead fails with an unhelpful error
if !FileExist("config.ini") {
    MsgBox("config.ini not found.`nCopy config-sample.ini to config.ini and start again.", "Keystassi", "Iconx")
    ExitApp()
}

MenuLoader.load("config.ini")
mystate := StateManager()

#Include *i includes.ahk

HotkeyLoader.load("config.ini")
HotkeyService.AssignHotkey(HotkeyLoader.hotkeys["toggleState"], (*) => mystate.toggleState(), ["all"])
HotkeyService.AssignHotkey(HotkeyLoader.hotkeys["exitApp"], (*) => ExitApp(), ["all-Active"])
HotkeyService.AssignHotkey(HotkeyLoader.hotkeys["moveUp"], (*) => mystate.moveUp(), ["all-Active"])
HotkeyService.AssignHotkey(HotkeyLoader.hotkeys["moveLeft"], (*) => mystate.moveLeft(), ["all-Active"])
HotkeyService.AssignHotkey(HotkeyLoader.hotkeys["moveDown"], (*) => mystate.moveDown(), ["all-Active"])
HotkeyService.AssignHotkey(HotkeyLoader.hotkeys["moveRight"], (*) => mystate.moveRight(), ["all-Active"])
HotkeyService.AssignHotkey(HotkeyLoader.hotkeys["executeStep"], (*) => mystate.enter(), ["all-Active"])
HotkeyService.UpdateHotkeys(mystate)