function Invoke-FirstRun() {
    Write-Host "Running first time initialization with 5 minutes timeout"

    $job = Start-Job { cd $using:pwd; java -jar rundeck.war > rundeck.log }
    for ($i=0; $i -le 300; $i++) {
        if ($i -eq 300) { throw "Error starting rundeck" }
        
        if (gc .\rundeck.log -ea 0 | sls "Rundeck startup finished") { 
            rjb $job -force; break 
        }
        sleep 1
    }
    rjb $job -force -ea 0
}

function Enable-RundeckSsl() {
    Write-Host "Enable self signed SSL"

    $p='HKLM:\SOFTWARE\JavaSoft\Java Development Kit'; $v=(gp $p).CurrentVersion; $jdk_home = (gp $p/$v).JavaHome
    $keytool_path = "$jdk_home\bin\keytool.exe"
    if (!(Test-Path $keytool_path)) { throw "Can't find keytool" }
    sal keytool $keytool_path
    
    $ErrorActionPreference = 'Continue'
    'Venkman.local','devops','my org','my city','my state','us','yes' | keytool -keystore etc\truststore -alias rundeck -genkey -keyalg RSA -keypass adminadmin -storepass adminadmin 2>$null
    $ErrorActionPreference = 'Stop'
    cp etc\truststore etc\keystore

    (gc server/config/rundeck-config.properties) -replace '4440','4443' -replace 'http://','https://' | sc server/config/rundeck-config.properties
    (gc start_rundeck.bat) -replace '^java', '$0 -Drundeck.ssl.config=%RDECK_BASE%/server/config/ssl.properties' | sc start_rundeck.bat

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
    $path = "start_rundeck.bat"

    $bat = gc $path
    if ($pp.CliOpts) { 
        Write-Host "Setting RDECK_CLI_OPTS to" $pp.CliOpts
        $bat = $bat -replace '^(set RDECK_CLI_OPTS=).+',"`$1$($pp.CliOpts)"
    }
    if ($pp.SslOpts) { 
        Write-Host "Setting RDECK_SSL_OPTS to" $pp.SslOpts
        $bat = $bat -replace '^::(set RDECK_SSL_OPTS=).+',"`$1$($pp.SslOpts)"
    }
    $bat | sc $path
}
function Set-RundeckAdminPass() {
    $path = "server\config\realm.properties"

    Write-Host "Setting up admin password"
    
    $realm = gc $path
    $realm -replace 'admin:admin', "admin:$($pp.AdminPwd)" | sc $path
}
function Set-RundeckDateFormat() {
    $path = "i18n\messages.properties"

    Write-Host "Setting up date formats in $path"

    mkdir i18n -ea 0 | Out-Null
    @(
        "jobslist.date.format=" + $pp.DateFormat
        'jobslist.date.format.ko=' + $pp.DateFormatKo
        'jobslist.running.format.ko=' + $pp.RunningFormatKo 
    ) | Set-Content $path
}

function Set-RundeckTokenDuration() {
    $path = "server\config\rundeck-config.properties"

    Write-Host "Setting token duration to" $pp.TokenDuration

    $config = Get-Content $path
    $config + "rundeck.api.tokens.duration.max=$($pp.TokenDuration)" | Set-Content $path 
}
