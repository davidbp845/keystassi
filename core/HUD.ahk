#Include ../utils/Debug.ahk
#Include ../utils/Monitor.ahk

class HUD {

    static ini() {
        dpiScale := Monitor.GetDpiScale()
        resScale := Monitor.GetResScale()
        
        guiWidth := 0.32 * 3840
        xPos := (A_ScreenWidth - guiWidth)/2
        yPos := 200
        xPos := xPos * resScale
        yPos := yPos * resScale
        guiWidth := guiWidth / dpiScale
        fontSize := 32 * resScale / dpiScale
        
        this.gui := Gui("+AlwaysOnTop -Caption +ToolWindow")
        this.gui.BackColor := "202020"

        this.gui.SetFont("s" fontSize " w400", "Courier New")
        this.text := this.gui.Add("Text", "cYellow r20 w" guiWidth , "")

        this.gui.Show("x" xPos " y" yPos " w" guiWidth " NoActivate")
        WinSetTransparent(200, this.gui.Hwnd)
    }

    static show() {
        WinSetTransparent(200, this.gui.Hwnd)
    }

    static hide() {
        WinSetTransparent(0, this.gui.Hwnd)
    }

    static render(menuState) {
        nodeType := (menuState.currentNode.isLeaf() ? "Step" : "Node")
        step := nodeType = "Step" ? menuState.currentNode.currentStep : ""
        textDebug := "currentNode " menuState.currentNode.label " " nodeType " " step
        UtilsDebug.Debug(textDebug)
        textShow := "Keystassi v0.0.1" "`n"
        textShow .= "----------------`n`n"
        textShow .= menuState.showPath()
        textShow .= "`n"
        if menuState.currentNode.hasChildren()
            textShow .= "`n" menuState.currentNode.showChildren(menuState.currentOption[menuState.currentOption.Length])
        else {
            ;  leaf
            if menuState.currentNode.hasSteps() {
                textShow .= "`n - Step " menuState.currentNode.currentStep " / " menuState.currentNode.GetStepsNumber()
                textShow .= "`n`n      Completion status - > " menuState.currentNode.showAllStepStatus()
            } else {
                textShow .= "`nEnd"
            }
        }
        HUD.text.Value := textShow
    }
}
