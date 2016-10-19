$ErrorActionPreference = 'Stop'

$packageName   = 'nirlauncher'
$url32         = 'http://download.nirsoft.net/nirsoft_package_1.19.107.zip'
$checksum32    = 'f41e596a67832af245a9f49c8761d75a1e56c3e3007cef5a24c18006b9b6a6ba'
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

if ($Env:ChocolateyPackageParameters -match '/SysInternals($| )') {
    Write-Host 'SysInternals utilities will be added'

    $sysinternals_dir = gcm autoruns.exe -ea 0 | select -Expand Source | Split-Path
    if (!$sysinternals_dir) { Write-Warning 'Sysinternals tools are not on the PATH' }

    #Download nlp
    Get-WebFile -Url http://download.nirsoft.net/sysinternals2.nlp -FileName $sysinternals_dir\sysinternals2.nlp 3>$null
    rm $sysinternals_dir/*.istext -ea 0

    #Configure nirlauncher
    $nircfg = gc $install_path\NirLauncher.cfg -Raw
    if ($nircfg -notmatch '\[Package1\]') {
        $nircfg = $nircfg.Replace("PackageCount=1", "PackageCount=2")
        $nircfg += "[Package1]`nfilename=$sysinternals_dir\sysinternals2.nlp"
        $nircfg | Out-File $install_path\NirLauncher.cfg -Encoding ascii
    }
}
