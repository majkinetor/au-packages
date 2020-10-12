$ErrorActionPreference = 'Stop'

$packageArgs = @{
    PackageName    = $Env:ChocolateyPackageName
    FileFullPath64 = gi $toolsPath\*.zip
    Destination    = $toolsPath
}

Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0
