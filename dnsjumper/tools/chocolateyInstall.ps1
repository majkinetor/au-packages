$ErrorActionPreference = 'Stop'

$packageName  = 'dnsjumper'
$url          = 'http://sordum.org/files/dns-jumper/DnsJumper.zip'
$chocoTempDir = Join-Path $Env:Temp "chocolatey"
$toolsDir     = Split-Path $MyInvocation.MyCommand.Definition
$tempZipFile  = "$chocoTempDir\dnsjumper.zip"
$Checksum     = '6c83c19f796aa104e28948d70149ef406e1b9a98'

mkdir -ea 0 $chocoTempDir | out-null

"Downloading $url ..."
$referer = "http://www.sordum.org/7952/dns-jumper-v2-0"
$wc = New-Object System.Net.WebClient
$wc.Headers.Add("Referer", $referer)
$wc.DownloadFile($url, $tempZipFile)

Get-ChocolateyUnzip -PackageName "$packageName" -FileFullPath "$tempZipFile" -Destination "$toolsDir"
rm $tempZipFile -ea 0 -force | out-null

$fileFullPath = $toolsDir +"\dnsjumper\dnsjumper.exe"
Get-CheckSumValid -file $fileFullPath -checkSum $checksum -checksumType 'sha1'
