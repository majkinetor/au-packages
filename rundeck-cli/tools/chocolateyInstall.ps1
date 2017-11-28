$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$rd_path = gi $toolsPath\*\bin\rd.bat
Install-BinFile rdcli $rd_path