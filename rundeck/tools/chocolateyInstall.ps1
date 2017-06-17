$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

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

if ($pp.CliOpts -or $pp.SslOpts) { Set-RundeckOpts }
if ($pp.AdminPwd)      { Set-RundeckAdminPass }
if ($pp.DateFormat)    { Set-RundeckDateFormat }
if ($pp.TokenDuration) { Set-RundeckTokenDuration }
if ($pp.EnableSsl)     { Enable-RundeckSsl }
if ($pp.ContainsKey('Service')) { Install-RundeckService }