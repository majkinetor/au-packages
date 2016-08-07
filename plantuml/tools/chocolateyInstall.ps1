$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$url         = 'http://sourceforge.net/projects/plantuml/files/plantuml.8046.jar/download'
$checksum    = '136997CD0D5C40B71B5CF9F45B5F1E93D3DBFA6C67B57A3679A628183C6F236E'
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
