#Include ../services/Hooks.ahk

class MenuNode {

    id := ""
    label := ""
    parent := ""
    children := []

    steps := []
    currentStep := ""
    stepStatus := []

    __New(id, label := "", steps := "") {
        this.id := id
        this.label := label
        this.parent := ""
        this.children := []
        this.steps := StrSplit(steps, ",")
        if steps {
            for _,stepName in this.steps {
                this.stepStatus.Push(0)
            }
            this.currentStep := 1
        } else {
            this.currentStep := ""
        }
    }

    isNotRoot() {
        return this.id != "root"
    }

    ; Children management
    ; -------------------

    isLeaf() {
        return !this.hasChildren()
    }

    hasChildren() {
        return this.children.Length > 0
    }

    getChildrenNumber() {
        return this.children.Length
    }

    addChild(childNode) {
        this.children.Push(childNode)
        childNode.parent := this
    }

    showChildren(currentOption) {
        textShow := ""
        i := 1
        for child in this.children {
            currentIndicator := (currentOption = i) ? "*" : " "
            textShow .= " - " child.label currentIndicator " "
            i++
        }
        return textShow
    }

    ; Step management and execution
    ; -----------------------------

    hasSteps() {
        return this.steps.Length > 0
    }

    getStepsNumber() {
        return this.steps.Length
    }

    nextStep() {
        if this.hasSteps() && this.currentStep < this.getStepsNumber() {
            this.currentStep++
        }
    }

    previousStep() {
        if this.hasSteps() && this.currentStep > 1
            this.currentStep--
    }

    resetSteps() {
        this.currentStep := 1
    }

    execute() {
        if this.isLeaf() {
            if this.hasSteps() {
                step := this.steps[this.currentStep]
                hookName := this.label "-" step
                OutputDebug("Executing hookName: " hookName)
                Hooks.do_action(hookName, this)
            } else {
                hookName := this.label
                OutputDebug("Executing hookName: " hookName)
                Hooks.do_action(hookName, this)
            }
        }
    }

    getStepStatus(stepNum) {
        return this.stepStatus[stepNum]
    }

    getCurrentStepStatus() {
        this.getStepStatus(this.currentStep)
    }

    setCurrentStepStatus(value) {
        if value < 0 || value > 100
            throw "Error stepStatus " value
        this.stepStatus[this.currentStep] := value
        statusShow := ""
        for _,val in this.stepStatus {
            statusShow .= val " "
        }
        UtilsDebug.Debug("setCurrentStepStatus: " statusShow)
    }

    showStepStatus(stepNum) {
        status := this.stepStatus[stepNum]
        if status < 10
            status := "  " status
        else if status < 100
            status := " " status
        else if status = 100
            status := "" status
        return this.stepStatus[stepNum] "%"
    }

    showCurentStepStatus() {
        return this.showStepStatus(this.currentStep)
    }

    showAllStepStatus() {
        textShow := ""
        for stepStatusIndex,stepStatusValue in this.stepStatus {
            UtilsDebug.Debug("stepStatusIndex: " stepStatusIndex)
            textShow .= this.showStepStatus(stepStatusIndex) ", "
        }
        return SubStr(textShow, 1, StrLen(textShow) - 2)
    }
}
