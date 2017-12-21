function Enable-RundeckSsl() {
    Write-Host "Enable self signed SSL"

    $p='HKLM:\SOFTWARE\JavaSoft\Java Development Kit'; $v=(gp $p).CurrentVersion; $jdk_home = (gp $p/$v).JavaHome
    $keytool_path = "$jdk_home\bin\keytool.exe"
    if (!(Test-Path $keytool_path)) { throw "Can't find keytool" }
    sal keytool $keytool_path
    
    mkdir etc -ea 0 | Out-Null
    $ErrorActionPreference = 'Continue'
    'Venkman.local','devops','my org','my city','my state','us','yes' | keytool -keystore etc\truststore -alias rundeck -genkey -keyalg RSA -keypass adminadmin -storepass adminadmin 2>$null
    $ErrorActionPreference = 'Stop'
    cp etc\truststore etc\keystore

    (gc server/config/rundeck-config.properties) -replace '4440','4443' -replace 'http://','https://' | sc server/config/rundeck-config.properties
    (gc start_rundeck.bat) -replace '^java', '$0 -Drundeck.ssl.config=%RDECK_BASE%/server/config/ssl.properties' | sc start_rundeck.bat

    if (!(Test-Path etc/framework.properties)) {
        Write-Host "Starting rundeck to generate etc/framework.properties"
        $job = Start-Job { cd $using:pwd; .\start_rundeck.bat }
        for ($i=0; $i -lt 120; $i++) { if (Test-Path etc/framework.properties) { rjb $job -force; break } else { sleep 1 } }
        rjb $job -force -ea 0
    }
    (gc etc/framework.properties) -replace '4440','4443' -replace 'http://','https://' | sc etc/framework.properties
    # (gc etc/preferences.properties) -replace 'http://','https://' | sc etc/preferences.properties
}

function Install-RundeckService() {
    Write-Host "Installing service 'rundeck'"
    nssm install rundeck "$($pp.InstallDir)\start_rundeck.bat"
    if ($pp.Service -ne 0) {
        Write-Host "Starting service"
        Start-Service rundeck
    }
}
function Set-RundeckOpts() {
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
function Set-RundeckAdminPass() {
    Write-Host "Setting up admin password"
    $realm = gc server\config\realm.properties
    $realm -replace 'admin:admin', "admin:$($pp.AdminPwd)" | sc server\config\realm.properties 
}
function Set-RundeckDateFormat() {
    Write-Host "Setting up date format to" $pp.DateFormat
    $m = gc server\exp\webapp\WEB-INF\grails-app\i18n\messages.properties
    $m -replace '(jobslist.date.format=).+', "`$1$($pp.DateFormat)" | sc server\exp\webapp\WEB-INF\grails-app\i18n\messages.properties
}

function Set-RundeckTokenDuration() {
    Write-Host "Setting token duration to" $pp.TokenDuration
    $config = gc server\config\rundeck-config.properties
    $config + "rundeck.api.tokens.duration.max=$($pp.TokenDuration)" | sc server\config\rundeck-config.properties 
}
