$ErrorActionPreference = "Stop"

$pp = Get-PackageParameters
if(!$pp.Password) {
    $pp.Password = [guid]::NewGuid().ToString("N")
    Write-Warning "You did not specify a password for the postgres user so an insecure one has been generated for you. Please change it immediately."
    Write-Warning "Generated password: $($pp.Password)"
}

$silentArgs = @{
    Mode                = "unattended"
    UnattendedModeUI    = "none"
    # ServerPort          = 5432
    SuperPassword       = $pp.Password
    Enable_ACLedit      = 1
    Install_Runtimes    = 0
}

$packageArgs = @{
    packageName     = $Env:ChocolateyPackageName
    fileType        = 'exe'
    url64           = 'https://get.enterprisedb.com/postgresql/postgresql-13.4-1-windows-x64.exe'
    checksum64      = '209EA9635B8BC824F80842683A1E881EC838AA462663355D9D3857D8619E587D'
    checksumType64  = 'sha256'
    url             = ''
    checksum        = ''
    checksumType32  = 'sha256'
    silentArgs      =  ($silentArgs.Keys | % { "--{0} {1}" -f $_.Tolower(), $silentArgs.$_}) -join ' '
    validExitCodes  = @(0)
    softwareName    = 'PostgreSQL 13*'
}
Install-ChocolateyPackage @packageArgs
Write-Host "Installation log: $Env:TEMP\install-postgresql.log"

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find install location"; return }
Write-Host "Installed to '$installLocation'"

if (!$pp.NoPath) { Install-ChocolateyPath "$installLocation\bin" -PathType 'Machine' }
