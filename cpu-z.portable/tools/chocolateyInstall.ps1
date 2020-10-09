$ErrorActionPreference = 'Stop'

$packageName = 'cpu-z.portable'
$url32       = 'http://download.cpuid.com/cpu-z/cpu-z_1.94-en.zip'
$url64       = $url32
$checksum32  = 'efd7a22b0ec76b98cf22ff302c6dc5f7b77baa4fa33f9476a231a53aef859b9b'
$checksum64  = $checksum32

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = $packageName
  url                    = $url32
  url64bit               = $url64
  checksum               = $checksum32
  checksum64             = $checksum64
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  unzipLocation          = $toolsPath
}

Install-ChocolateyZipPackage @packageArgs
if (Get-ProcessorBits 64) {
    Remove-Item $toolsPath\cpuz_x32.exe
    Move-Item -force $toolsPath\cpuz_x64.exe $toolsPath\cpuz.exe
} else {
    Remove-Item $toolsPath\cpuz_x64.exe
    Move-Item -force $toolsPath\cpuz_x32.exe $toolsPath\cpuz.exe
}
# create empty sidecar so shimgen creates shim for GUI rather than console
Set-Content -Path (Join-Path -Path $toolsDir -ChildPath "cpuz.exe.gui") `
            -Value $null

Write-Host "$packageName installed to $toolsPath"
