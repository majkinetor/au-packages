$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
if ($pp.Path) {
   # make sure the path string is valid
   $null = [system.io.fileinfo]($pp.Path)
   Write-Host "Solr will be unpacked to the custom location, '$($pp.Path)'."
   Write-Warning 'Custom locations are not identified or cleared on Chocolatey package upgrade or uninstall.'
   if (-not (Test-Path $pp.Path)) {
      Write-Host "Creating destination directory, '$($pp.Path)'"
      $null = New-Item -Path $pp.Path -ItemType Directory
   }
   $UnzipPath = $pp.Path
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
