$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$url         = 'https://sourceforge.net/projects/plantuml/files/plantuml.8053.jar/download'
$checksum    = '9551a8d4a7cce5c7a2fb1124910ff7347aee9a3a90ff2e451d6629fe82f7a380'
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition
$tmpPath     = "$Env:TMP\chocolatey\$packagename"
$cmdPath     = join-path $env:ChocolateyInstall bin\plantuml.cmd

$params = @{
    PackageName    = $packageName
    FileFullPath   = "$tmpPath\plantuml.jar"
    Url            = $url
    Url64Bit       = $url
    checksum       = $checksum
    checksum64     = $checksum
    checksumType   = 'sha256'
    checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @params

cp "$tmpPath\plantuml.jar" $toolsPath
"start java -jar ""$toolsPath\plantuml.jar"" %*" | out-file $cmdPath -Encoding ascii

Write-Host "Plantuml installed in: $toolsPath\plantuml"
