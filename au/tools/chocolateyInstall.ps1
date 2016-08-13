$ErrorActionPreference = 'Stop'

$packageName = 'au'
$url32       = 'https://github.com/majkinetor/au/archive/2016.8.12.zip'
$url64       = $url32
$checksum32  = 'B80085CD0D33921C2B0339CACCA493C04EB2CD873936CA7E397EDC262F3B1E2E'
$checksum64  = $checksum32
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $packageName
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs

$module_src = gi $toolsPath\au*
$module_dst = "$Env:UserProfile\Documents\WindowsPowerShell\Modules\$packageName\$Env:ChocolateyPackageVersion"
mkdir -force $module_dst | out-null
mv -force $module_src\* $module_dst
