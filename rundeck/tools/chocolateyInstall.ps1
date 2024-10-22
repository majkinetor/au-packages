$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

Update-SessionEnvironment   # Java might have been installed as dependency

$pp = Get-PackageParameters rundeck
if (!$pp.InstallDir) { $pp.InstallDir = 'C:\rundeck' }

Write-Host "Installing to" $pp.InstallDir
mkdir $pp.InstallDir -ea 0 | Out-Null

$checksum32 = 'c0aa5d024dec77b9afb83e4b2ae053d8cf98d81e4a38a9a18a2c04d64ae92b2c'
$url = 'https://packagecloud.io/pagerduty/rundeck/packages/java/org.rundeck/rundeck-5.7.0-20241021.war/artifacts/rundeck-5.7.0-20241021.war/download'
Get-ChocolateyWebFile rundeck "$($pp.InstallDir)\rundeck.war" $url -Checksum $checksum32

Write-Host "Setting up machine environment variable RDECK_BASE"
Install-ChocolateyEnvironmentVariable 'RDECK_BASE' $pp.InstallDir 'Machine'

mv -Force $toolsDir\start_rundeck.bat $pp.InstallDir
cd $pp.InstallDir

Invoke-FirstRun

if ($pp.CliOpts -or $pp.SslOpts -or $pp.TimeZone) { Set-RundeckOpts }
if ($pp.AdminPwd)      { Set-RundeckAdminPass }
if ($pp.DateFormat)    { Set-RundeckDateFormat }
if ($pp.TokenDuration) { Set-RundeckTokenDuration }
if ($pp.EnableSsl)     { Enable-RundeckSsl }
if ($pp.ContainsKey('Service')) { Install-RundeckService }
