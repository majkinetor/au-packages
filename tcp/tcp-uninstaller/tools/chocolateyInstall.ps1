$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

Install-TCPlugin $toolsPath\uninstaller64_1.0.1.rar Uninstaller64
