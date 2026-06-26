#Include ../utils/Debug.ahk
#Include HUD.ahk
#Include MenuLoader.ahk

class StateManager {

    menuActive := true
    currentNode := ""
    currentOption := []
    currentPath := []
    leafMode := false

    __New() {
        this.currentOption.Push(1)
        rootNode := MenuLoader.menuNodes["root"]
        this.currentNode := rootNode
        this.currentPath.Push(rootNode.label)
        HUD.ini()
        this.updateHud()
    }

    toggleState() {
        this.menuActive := !this.menuActive
        HotkeyService.UpdateHotkeys(this)
        if this.menuActive {
            HUD.show()
        } else {
            HUD.hide()
        }
    }

    isMenuActive() {
        return this.menuActive
    }

    updateHud() {
        HUD.render(this)
    }

    showPath(separator := " \ ") {
        pathText := ""
        for _, pathElem in this.currentPath {
            pathText .= pathElem separator
        }
        return pathText
    }

    showState(showActivationStatus:=false) {
        stateText := this.showPath("-")
        stateText := SubStr(stateText, 1, StrLen(stateText) - 1)
        if showActivationStatus
            stateText .= "-" . (this.menuActive ? "Active" : "Inactive")
        UtilsDebug.Debug("showState " stateText)
        return stateText
    }

    isLeafMode() {
        return this.isLeafMode
    }

    isLeafNode() {
        return this.currentNode.isLeaf()
    }

    moveUp() {
        ; W
        if this.currentNode.isNotRoot() {
            if !this.isLeafNode() {
                this.currentNode := this.currentNode.parent
                this.currentOption.Pop()
                this.currentPath.Pop()
            } else {
                this.currentNode := this.currentNode.parent
                this.currentNode.resetSteps()
                this.currentOption.Pop()
                this.currentPath.Pop()
            }
        }
        this.updateHud()
    }

    moveLeft() {
        ; A
        if !this.isLeafNode() {
            current := this.currentOption[this.currentOption.Length]
            newOption := Max(current - 1, 1)
            if newOption < current {
                this.currentOption[this.currentOption.Length] := newOption
                this.updateHud()
            }
        } else {
            this.currentNode.previousStep()
        }
        this.updateHud()
    }

    moveDown() {
        ; S
        if !this.isLeafNode() {
            if this.currentNode.hasChildren() {
                option := this.currentOption[this.currentOption.Length]
                this.currentNode := this.currentNode.children[option]
                this.currentOption.Push(1)
                this.currentPath.Push(this.currentNode.label)
            }
        } else {
            if !this.isLeafMode() {
                this.currentNode.resetSteps()
                this.currentOption.Push(1)
                this.currentPath.Push(this.currentNode.label)
            }
        }
        this.updateHud()
    }

    moveRight() {
        ;D
        if !this.isLeafNode() {
            current := this.currentOption[this.currentOption.Length]
            newOption := Min(current + 1, this.currentNode.getChildrenNumber())
            if newOption > current {
                this.currentOption[this.currentOption.Length] := newOption
            }
        } else {
            this.currentNode.nextStep()
        }
        this.updateHud()
    }

    enter() {
        if this.isLeafMode() {
            this.currentNode.execute()
            this.updateHud()
        }
    }
}
