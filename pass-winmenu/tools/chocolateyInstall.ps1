$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$running = ps pass-winmenu -ea 0 | kill -PassThru

$pp = Get-PackageParameters
$installDir    = if ($pp.InstallDir ) { $pp.InstallDir } else { "$(Get-ToolsLocation)\pass-winmenu" }
$passwordStore = if ($pp.PasswordStore) { $pp.PasswordStore } else {  "$Home\.password-store" }

$packageArgs = @{
    PackageName    = 'pass-winmenu'
    FileFullPath   = gi $toolsPath\*.zip
    Destination    = $installDir
}

Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
cp $installDir\pass-winmenu\* $installDir -Recurse -Force
rm $installDir\pass-winmenu -Recurse -Force

$config = gc $installDir\pass-winmenu.yaml -Encoding UTF8
if ($pp.PasswordStore) { $config = $config -replace '^password-store: .+', "password-store: $passwordStore" }
$config | Set-Content $installDir\pass-winmenu.yaml -Encoding UTF8

if (!(Test-Path $passwordStore)) {
    Write-Host "Creating password store: $passwordStore"
    mkdir $passwordStore -ea 0 | Out-Null
}

if ($pp.GpgId) { 
    Write-Host "Setting up GpgId to $($pp.GpgId)"
    $pp.GpgId | Out-File -Encoding utf8 $passwordStore\.gpg-id 
}

if ($running) { start $installDir\pass-winmenu.exe }
