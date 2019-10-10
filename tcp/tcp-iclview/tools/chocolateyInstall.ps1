$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\tcps.ps1

Install-TCPlugin IclView -DetectString 'MULTIMEDIA & (ext="DLL" | ext="EXE" | ext="ICL" | ext="ICL32" | ext="ICO" | size=0 | force)'
