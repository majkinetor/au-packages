$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
ls $toolsPath\helpers\*.ps1 | % { . $_ }

Install-TCPlugin $toolsPath\wfx_envvars_1.0a.zip 'EnvVars'
