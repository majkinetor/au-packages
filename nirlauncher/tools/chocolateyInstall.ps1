$ErrorActionPreference = 'Stop'

$packageName   = 'nirlauncher'
$url32         = 'http://download.nirsoft.net/nirsoft_package_1.19.106.zip'
$checksum32    = '01bc2a8a094a80e64481dea189b9df847c2f24f266401a97bcae113b56a1bdfc'
$download_path = "$env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion\nirlauncher.zip"
$install_path  = "$(Get-ToolsLocation)\NirLauncher"

$options =  @{ Headers=@{ Referer = 'http://launcher.nirsoft.net/download.html' } }
Get-WebFile -Url $url32 -FileName $download_path -Options $options

Write-Host "Installing $packageName to '$install_path'"
$packageArgs = @{
  packageName    = $packageName
  url            = $download_path
  url64Bit       = $download_path
  checksum       = $checksum32
  checksum64     = $checksum32
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $install_path
}
Install-ChocolateyZipPackage @packageArgs

if (Get-ProcessorBits 64) {
    Write-Host '64 bit architecture - overwriting x32 apps with x64 versions'
    mv $install_path\Nirsoft\x64\* $install_path\Nirsoft -force
    rm $install_path\Nirsoft\x64 -ea 0
}
Install-ChocolateyPath $install_path\Nirsoft "Machine"

$launcher_path = "$install_path\$packageName.exe"
Register-Application $launcher_path
Write-Host "$packageName registered as $packageName"

Install-BinFile $packageName $launcher_path

Write-Host "Removing shims from older package installs if needed"
ls $install_path\Nirsoft\*.exe | % { Uninstall-BinFile $_.Name }

