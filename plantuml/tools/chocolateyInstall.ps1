$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$url         = 'http://sourceforge.net/projects/plantuml/files/plantuml.8048.jar/download'
$checksum    = 'e500ea94600ecade4af7262b32ea20a1c884de0013f4a3f07aeae02d594424ab'
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
