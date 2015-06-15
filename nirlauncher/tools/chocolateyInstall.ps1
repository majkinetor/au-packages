$packageName   = 'nirlauncher.portable'
$url           = 'http://download.nirsoft.net/nirsoft_package_1.19.37.zip'
$version       = $url -split '_|.zip' | select -Last 1 -Skip 1
$installDir    = "$env:ChocolateyBinRoot\NirLauncher"
$downloadPath  = "$env:TEMP\$($packageName)_$version.zip"

Write-Host "Downloading NirLauncher v$version ..."
$client = New-Object System.Net.WebClient
$client.Headers.Add('Referer','http://launcher.nirsoft.net/download.html')
$client.DownloadFile($url, $downloadPath)

Write-Host "Local path: $installDir"
Install-ChocolateyZipPackage $packageName $downloadPath $installDir
rm $downloadPath

Write-Host "Adding NirLuancher utilities to the PATH if needed"
"$installDir","$installDir\Nirsoft" | % { Install-ChocolateyPath $_ "Machine" }

