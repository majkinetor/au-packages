$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\totalcmd.ps1

Uninstall-TCPlugin Uninstaller64