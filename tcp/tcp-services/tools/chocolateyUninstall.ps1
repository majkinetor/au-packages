$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
ls $toolsPath\helpers\*.ps1 | % { . $_ }

Uninstall-TCPlugin Services2