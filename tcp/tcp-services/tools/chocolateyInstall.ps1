$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
ls $toolsPath\helpers\*.ps1 | % { . $_ }

Install-TCPlugin $toolsPath\wfx_Services2_0.7.0.rar Services2
