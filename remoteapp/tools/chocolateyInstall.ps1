$ErrorActionPreference = 'Stop'

$toolsPath  = Split-Path $MyInvocation.MyCommand.Definition
$installDir = Join-Path (Get-ToolsLocation) "RemoteApp"

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath   = Get-Item $toolsPath\remoteapptool5300.zip
    Destination    = $installDir
}
Get-ChocolateyUnzip @packageArgs
Copy-Item $toolsPath\raweb0051.zip $installDir
Remove-Item $toolsPath\*.zip -ea 0
