$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$installDir = Get-RunnerInstallDir
if (!$current_dir) { Write-Warning "Can't find gitlab-runner installation directory, aborting"; return }

pushd $installDir
.\gitlab-runner.exe stop
.\gitlab-runner.exe uninstall
popd

rm $installDir -Force
