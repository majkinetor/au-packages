$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = 'C:\rundeck' }

Write-Host "Installing to" $pp.InstallDir
mkdir $pp.InstallDir -ea 0 | Out-Null

Write-Host "Setting up machine environment variable RDECK_BASE"
Install-ChocolateyEnvironmentVariable 'RDECK_BASE' $pp.InstallDir 'Machine'

Write-Host "Copying files"
mv -Force $toolsDir\*.jar "$($pp.InstallDir)\rundeck-launcher.jar" 
mv -Force $toolsDir\start_rundeck.bat $pp.InstallDir
cd $pp.InstallDir

Write-Host "Running with --installonly"
java -jar rundeck-launcher.jar --installonly

if ($pp.Service) {
    Write-Host "Installing service"
    nssm install rundeck "$($pp.InstallDir)\start_rundeck.bat"

    Write-Host "Starting service"
    Start-Service rundeck
}