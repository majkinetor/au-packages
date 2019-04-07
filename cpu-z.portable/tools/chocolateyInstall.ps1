$ErrorActionPreference = 'Stop'

$packageName = 'cpu-z.portable'
$url32       = 'http://download.cpuid.com/cpu-z/cpu-z_1.88-en.zip'
$url64       = $url32
$checksum32  = '0fd6fdafce4219ede90e1122f75f2b13dd0a751f5bb535ae3ee597293ba189ab'
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
    rm $toolsPath\cpuz_x32.exe
    mv $toolsPath\cpuz_x64.exe $toolsPath\cpuz.exe
} else {
    rm $toolsPath\cpuz_x64.exe
    mv $toolsPath\cpuz_x32.exe $toolsPath\cpuz.exe
}
Write-Host "$packageName installed to $toolsPath"
