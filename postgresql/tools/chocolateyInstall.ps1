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
    ServerPort          = 5432
    SuperPassword       = $pp.Password
    Enable_ACLedit      = 1
    Install_Runtimes    = 0
}

$packageArgs = @{
    packageName     = $Env:ChocolateyPackageName
    fileType        = 'exe'    
    url64           = 'https://get.enterprisedb.com/postgresql/postgresql-9.4.26-1-windows-x64.exe'
    checksum64      = '028F48ACB0AC5AEC5B6C4B87BA827030932427A3511BEB6BE2784BFCB51E8F20'
    checksumType64  = 'sha256'
    url             = 'https://get.enterprisedb.com/postgresql/postgresql-9.4.26-1-windows.exe'
    checksum        = '19AE10CD609DE09BD0D1890076AF3D429B5FEC0FEDD22F65CF158AC0773FBD4C'
    checksumType32  = 'sha256'
    silentArgs      =  ($silentArgs.Keys | % { "--{0} {1}" -f $_.Tolower(), $silentArgs.$_}) -join ' '
    validExitCodes  = @(0)
    softwareName    = 'PostgreSQL 9*'  
}
Install-ChocolateyPackage @packageArgs
Write-Host "Installation log: $Env:TEMP\install-postgresql.log"

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find install location"; return }
Write-Host "Installed to '$installLocation'"

if (!$pp.NoPath) { Install-ChocolateyPath "$installLocation\bin" -PathType 'Machine' }
