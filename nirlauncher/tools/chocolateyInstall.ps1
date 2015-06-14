$packageName   = 'nirlauncher.portable'
$url           = 'http://download.nirsoft.net/nirsoft_package_1.19.37.zip'
$version       = $url -split '_|.zip' | select -Last 1 -Skip 1
$installDir    = Split-Path -parent $MyInvocation.MyCommand.Definition
$zipPath       = "$installDir\$($packageName)_$version.zip"


Write-Host "Downloading NirLauncher v$version ..."
$client = New-Object System.Net.WebClient
$client.Headers.Add('Referer','http://launcher.nirsoft.net/download.html')
$client.DownloadFile($url, $zipPath)

Write-Host "Local path: $installDir"
Install-ChocolateyZipPackage $packageName $zipPath $installDir
rm $zipPath
