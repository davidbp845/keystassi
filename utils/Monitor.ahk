#Include Debug.ahk

class Monitor {
    static GetDpiScale() {
        dpi := A_ScreenDPI
        dpiScale := dpi / 96
        ;UtilsDebug.Debug("GetDpiScale dpiScale: " dpiScale)
        return dpiScale
    }

    static GetResScale() {
        screenW := A_ScreenWidth
        screenH := A_ScreenHeight
        ;UtilsDebug.Debug("GetResScale screenW: " screenW)
        ;UtilsDebug.Debug("GetResScale screenH: " screenH)

        baseWidth := 3840
        baseHeight := 2160

        resScaleX := screenW / baseWidth
        resScaleY := screenH / baseHeight
        resScale := Min(resScaleX, resScaleY)

        ;UtilsDebug.Debug("GetResScale resScale: " resScale)
        return resScale
    }
}