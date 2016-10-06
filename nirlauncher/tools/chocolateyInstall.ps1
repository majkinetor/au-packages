$ErrorActionPreference = 'Stop'

$packageName  = 'nirlauncher'
$url32        = 'http://download.nirsoft.net/nirsoft_package_1.19.105.zip'
$checksum32   = '34b5764689af9c7ca7e53ac004d73e6279b10a3565c838b0f5a3e34d49000fca'
$toolsPath    = Split-Path $MyInvocation.MyCommand.Definition
$downloadPath = "$env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion\nirlauncher.zip"

$options =  @{ Headers=@{ Referer = 'http://launcher.nirsoft.net/download.html' } }
Get-WebFile -Url $url32 -FileName $downloadPath -Options $options

#Write-Host "Adding NirLuancher utilities to the PATH if needed"
#"$installDir","$installDir\Nirsoft" | % { Install-ChocolateyPath $_ "Machine" }

$packageArgs = @{
  packageName    = $packageName
  url            = $downloadPath
  url64Bit       = $downloadPath
  checksum       = $checksum32
  checksum64     = $checksum32
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $toolsPath
}
Install-ChocolateyZipPackage @packageArgs
