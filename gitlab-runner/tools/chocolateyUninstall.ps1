$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

gitlab-runner.exe stop
gitlab-runner.exe uninstall

Write-Warning 'If a service user is created during the installation, it is not removed as safety measure'
WRite-Warning 'Execute the following if you want to remove it: net user <username> /delete'

$installDir = Get-RunnerInstallDir
if (!$current_dir) { Write-Warning "Can't find gitlab-runner installation directory, please remove it manually"; return }
rm $installDir -Force
