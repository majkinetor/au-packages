
$at    = "07:00"
$limit = New-TimeSpan -Hours 1
$user = "$env:USERDOMAIN\$env:USERNAME"

$a = New-ScheduledTaskAction -Execute powershell -Argument '-NoProfile -File update_all.ps1' -WorkingDirectory $pwd
$t = New-ScheduledTaskTrigger -Daily -At $at
$s = New-ScheduledTaskSettingsSet -ExecutionTimeLimit $Limit -DontStopIfGoingOnBatteries -AllowStartIfOnBatteries -Compatibility Win8 -StartWhenAvailable

$params = @{
    Force    = $True
    TaskPath = $user
    Action   = $a
    Trigger  = $t
    Settings = $s
    Taskname = "Update Chocolatey Packages"
}
Register-ScheduledTask @params
