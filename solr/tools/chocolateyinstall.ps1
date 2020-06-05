$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
if ($pp['path']) {
   # make sure the path string is valid
   $null = [system.io.fileinfo]($pp['path'])
   Write-Host "Solr will be unpacked to the custom location, '$($pp['path'])'."
   Write-Warning 'Custom locations are not identified or cleared on Chocolatey package upgrade or uninstall.'
   if (-not (Test-Path $pp['path'])) {
      Write-Host "Creating destination directory, '$($pp['path'])'"
      $null = New-Item -Path $pp['path'] -ItemType Directory
   }
   $UnzipPath = $pp['path']
} else {
   $UnzipPath = Get-ToolsLocation
   Write-Host "Solr will be unpacked to the default location, '$UnzipPath'."
}

$packageArgs = @{
    PackageName  = 'solr'
    FileFullPath = Get-Item $toolsPath\*.zip  
    Destination  = $UnzipPath
}

Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0