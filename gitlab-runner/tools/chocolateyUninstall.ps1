$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$current_dir = Get-RunnerInstallDir
if (!$current_dir) { Write-Warning "Can't find gitlab-runner installation directory, aborting"; return }

cd $current_dir
.\gitlab-runner.exe stop
.\gitlab-runner.exe uninstall

rm $current_dir -Force
