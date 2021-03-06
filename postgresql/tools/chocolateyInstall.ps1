﻿$ErrorActionPreference = "Stop"

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
    url64           = 'https://get.enterprisedb.com/postgresql/postgresql-10.17-2-windows-x64.exe'
    checksum64      = 'A0D34E4E0E90F445B0CDBC4FFC68BF55F2E297E58E738D84D92B2AE1A7FA7448'
    checksumType64  = 'sha256'
    url             = 'https://get.enterprisedb.com/postgresql/postgresql-10.17-1-windows.exe'
    checksum        = 'B88EC7B4DF6050D866739B5A2766933E4F9E5E62F142F8BC8E310114DBB44BF1'
    checksumType32  = 'sha256'
    silentArgs      =  ($silentArgs.Keys | % { "--{0} {1}" -f $_.Tolower(), $silentArgs.$_}) -join ' '
    validExitCodes  = @(0)
    softwareName    = 'PostgreSQL 10*'
}
Install-ChocolateyPackage @packageArgs
Write-Host "Installation log: $Env:TEMP\install-postgresql.log"

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find install location"; return }
Write-Host "Installed to '$installLocation'"

if (!$pp.NoPath) { Install-ChocolateyPath "$installLocation\bin" -PathType 'Machine' }
