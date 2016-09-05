$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$url         = 'http://sourceforge.net/projects/plantuml/files/plantuml.8047.jar/download'
$checksum    = '955ad9dab7e53c8df427d1d56eafa40e558c6e551dcf64f161bb7aaa20c34185'
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
