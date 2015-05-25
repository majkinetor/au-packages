$packageName = 'CopyQ'
$installerType = 'EXE' #only one of these: exe, msi, msu
$url = 'https://github.com/hluk/CopyQ/releases/download/v2.4.6/copyq-2.4.6-setup.exe' # download url
#$url64 = 'URL_x64_HERE' # 64bit URL here or remove - if installer decides, then use $url
$silentArgs = '/VERYSILENT'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
