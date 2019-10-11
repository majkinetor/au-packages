$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\tcps.ps1

Install-TCPlugin peviewer -DetectString 'ext="EXE"|ext="DLL"|ext="OCX"|FORCE'
