$ErrorActionPreference = 'Stop'

$packageName = 'plantuml'
$url         = 'http://netix.dl.sourceforge.net/project/plantuml/plantuml.8037.jar'
$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition
$cmdPath     = join-path $env:ChocolateyInstall $env:chocolatey_bin_root\plantuml.cmd


$params = @{
    PackageName = $packageName
    FileFullPath ="$toolspath\plantuml.jar"
    Url         = $url
    Url64Bit    = $url
}
Get-ChocolateyWebFile @params
"start java -jar ""$toolsPath\plantuml.jar"" %*" | out-file $cmdPath -Encoding ascii

Write-Host "Plantuml installed in: $toolsPath\plantuml"
