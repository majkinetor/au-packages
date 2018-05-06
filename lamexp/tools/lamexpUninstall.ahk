SetTitleMatchMode, RegEx

WinWait, LameXP .+ Uninstall ahk_class #32770, , 60
if (!ErrorLevel) {
    BlockInput On
    WinActivate
    Send {Enter}
    BlockInput Off
}
