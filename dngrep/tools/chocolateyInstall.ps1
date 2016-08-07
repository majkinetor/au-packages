$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x86.msi'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x64.msi'
$checksum32  = 'CE4753735148E1F48FE0E1CD9AA4DFD019082F4F43C38C4FF4157F08D346700C'
$checksum64  = '025BD4101826932E954AACD3FE6AEE9927A7198FEEFFB24F82FBE5D578502D18'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'MSI'
  url                    = $url32
  url64bit               = $url64
  silentArgs             = '/quiet'
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$exePath = gp HKLM:\SOFTWARE\Classes\Directory\background\shell\dnGREP\command -ea 0 | select -expand '(default)'
$exePath = $exePath -split '"' | select -Index 1
if (Test-Path $exePath) {
    "Installation directory: " + (Split-Path $exePath -Parent)
    $AppPathKey = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"
    If (!(Test-Path $AppPathKey)) {New-Item "$AppPathKey" | Out-Null}
    Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value $exePath
}
