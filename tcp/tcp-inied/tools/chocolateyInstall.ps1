$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\tcps.ps1

Install-TCPlugin IniEd -DetectString '(ext="INI") | (ext="INF") | (ext="REG") | (ext="URL")'
