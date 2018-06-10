$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
ls $toolsPath\helpers\*.ps1 | % { . $_ }

Install-TCPlugin $toolsPath\uninstaller64_1.0.1.rar Uninstaller64
