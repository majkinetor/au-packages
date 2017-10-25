#NoEnv
SetTitleMatchMode RegEx

IfExist, %1%
{
	Run, %1%
	WinWait,Exact Audio Copy [\d\.]+ Uninstall,, 30
	IfWinExist
	{
		BlockInput, On
		Sleep, 250
		WinActivate
		SendInput, {Left}, {Enter}
		BlockInput, Off
	}
	WinWait, Exact Audio Copy [\d\.]+ Uninstall, successfully, 30
	IfWinExist
	{
		BlockInput, On
		Sleep, 250
		WinActivate
		SendInput, {Enter}
		BlockInput, Off
	}
	exit
}