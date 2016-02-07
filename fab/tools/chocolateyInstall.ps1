$ErrorActionPreference = 'Stop'

$packageName  = 'fab'
$url          = 'http://sordum.org/files/firewall-app-blocker/fab_v1.4.zip'
$chocoTempDir = Join-Path $Env:Temp "chocolatey"
$toolsDir     = Split-Path $MyInvocation.MyCommand.Definition
$tempZipFile  = "$chocoTempDir\fab.zip"
$Checksum     = '7762ff1fbd5cd16cf6679d97623543edbe758806'

mkdir -ea 0 $chocoTempDir | out-null

"Downloading $url ..."
$referer = 'http://www.sordum.org/8125/firewall-app-blocker-fab-v1-4'
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("Referer", $referer)
$wc.DownloadFile($url, $tempZipFile)

Get-ChocolateyUnzip -PackageName "$packageName" -FileFullPath "$tempZipFile" -Destination "$toolsDir"
rm $tempZipFile -ea 0 -force | out-null

$fileFullPath = $toolsDir +"\fab_v1.4\fab.exe"
Get-CheckSumValid -file $fileFullPath -checkSum $checksum -checksumType 'sha1'
