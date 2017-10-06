if (Get-Service rundeck -ea 0) {
    Write-Host "Removing service"
    Stop-Service rundeck
    nssm remove rundeck confirm
}

Write-Host "Removing $Env:RDECK_BASE"
rm $Env:RDECK_BASE -Recurse -ea 0

Write-Host "Removing environment variable"
Uninstall-ChocolateyEnvironmentVariable 'RDECK_BASE' 'Machine'