$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$url         = 'https://sourceforge.net/projects/plantuml/files/plantuml.8052.jar/download'
$checksum    = 'e0a12c80005291880e81635e1a96828cc28496f92839558f9f3b892f508629a5'
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
