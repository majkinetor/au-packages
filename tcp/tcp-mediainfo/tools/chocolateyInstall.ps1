$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\tcps.ps1

Write-Host "Content plugin:"
Install-TCPlugin TCMediaInfo -DetectString "MULTIMEDIA | FORCE"
Write-Host "Lister plugin:"
Install-TCPlugin TCMediaInfo -DetectString "MULTIMEDIA | FORCE" -ForceType Wlx -NoExpand
