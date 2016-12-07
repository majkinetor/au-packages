$ErrorActionPreference = 'Stop'

$fileName  = ''
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$zip_path = "$toolsPath\$fileName"
rm $toolsPath\* -Recurse -Force -Exclude $fileName

$packageArgs = @{
    PackageName  = ''
    FileFullPath = $zip_path
    Destination  = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
rm $zip_path -ea 0
