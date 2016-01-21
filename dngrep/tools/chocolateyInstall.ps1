$ErrorActionPreference = 'Stop'

$packageName = 'dngrep'
$exeName     = 'dnGREP.exe'
$url64       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x64.msi'
$url32       = 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x86.msi'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'MSI'
  url                    = $url32
  url64bit               = $url64
  silentArgs             = '/quiet'
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
