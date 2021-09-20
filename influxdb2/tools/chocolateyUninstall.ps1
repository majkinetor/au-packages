if (Get-Service $Env:ChocolateyPackageName -ea 0) {
    Write-Host "Removing service"
    Stop-Service $Env:ChocolateyPackageName
    nssm remove $Env:ChocolateyPackageName confirm
} else { Write-Host "Nothing done, service '$Env:ChocolateyPackageName' not found" }