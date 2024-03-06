$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

Update-SessionEnvironment   # Java might have been installed as dependency

$pp = Get-PackageParameters rundeck
if (!$pp.InstallDir) { $pp.InstallDir = 'C:\rundeck' }

Write-Host "Installing to" $pp.InstallDir
mkdir $pp.InstallDir -ea 0 | Out-Null

$checksum32 = 'e90103fefbda38c94075a22521e1aaaf1f76270e24473f45113ae2c1f09d09cf'
$url = 'https://packagecloud.io/pagerduty/rundeck/packages/java/org.rundeck/rundeck-5.1.1-20240305.war/artifacts/rundeck-5.1.1-20240305.war/download'
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
