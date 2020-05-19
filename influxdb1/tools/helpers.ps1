
function Install-InfluxDbService ($ServiceName = 'influxdb1') {
    Write-Host "Installing service '$ServiceName'"

    $installDir = Get-ChildItem $pp.InstallRoot | Sort-Object CreationTime | Select-Object -Last 1
    $installDir = $installDir.FullName
    nssm install $ServiceName "$installDir\influxd.exe"
    if ($pp.Service -ne 0) {
        Write-Host "Starting service"
        Start-Service $ServiceName
    }
}