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

if ($pp.CliOpts -or $pp.SslOpts) {
    $bat = gc start_rundeck.bat
    if ($pp.CliOpts) { 
        Write-Host "Setting RDECK_CLI_OPTS to" $pp.CliOpts
        $bat = $bat -replace '^(set RDECK_CLI_OPTS=).+',"`$1$($pp.CliOpts)"
    }
    if ($pp.SslOpts) { 
        Write-Host "Setting RDECK_SSL_OPTS to" $pp.SslOpts
        $bat = $bat -replace '^::(set RDECK_SSL_OPTS=).+',"`$1$($pp.SslOpts)"
    }
    $bat | sc start_rundeck.bat
}

if ($pp.AdminPwd) {
    Write-Host "Setting up admin password"
    $realm = gc server\config\realm.properties
    $realm -replace 'admin:admin', "admin:$($pp.AdminPwd)" | sc server\config\realm.properties 
}

if ($pp.DateFormat) {
    Write-Host "Setting up date format to" $pp.DateFormat
    $m = gc server\exp\webapp\WEB-INF\grails-app\i18n\messages.properties
    $m -replace '(jobslist.date.format=).+', "`$1$($pp.DateFormat)" | sc server\exp\webapp\WEB-INF\grails-app\i18n\messages.properties
}

if ($pp.TokenDuration) {
    Write-Host "Setting token duration to" $pp.TokenDuration
    $config = gc server\config\rundeck-config.properties
    $config + "rundeck.api.tokens.duration.max=$($pp.TokenDuration)" | sc server\config\rundeck-config.properties 
}

if ($pp.Service) {
    Write-Host "Installing service"
    nssm install rundeck "$($pp.InstallDir)\start_rundeck.bat"

    Write-Host "Starting service"
    Start-Service rundeck
}