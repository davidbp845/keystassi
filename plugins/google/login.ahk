#Include ../../core/HUD.ahk
#Include ../../services/Hooks.ahk

Hooks.add_action("Gmail-Step1", GmailStep1Action)
; -----------------------
GmailStep1Action(menuNode) {
    Run "https://www.google.com"
    Sleep 200
    menuNode.setCurrentStepStatus(100)
}