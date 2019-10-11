$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. C:\Work\au-packages\tcp\tcps\tools\totalcmd.ps1 #$Env:ChocolateyInstall\lib\tcps\tools\totalcmd.ps1

$pp = Get-PackageParameters
if (!$pp.FontSize) { $pp.FontSize = 10 }

Write-Host "Setting Total Commander Configuration: $Env:ChocolateyPackageName"
Write-Host "Configurable parameters:"
Write-Host "  Font size: $($pp.FontSize)"
@{
    AllResolutions = @{
        FontSize   = $pp.FontSize
        FontWeight = 400
    }
    Configuration = @{
        onlyonce  = 1
        AltSearch = 3
        QuickSearchMatchBeginning = 0
        QuickSearchExactMatch = 0
        RenameSelOnlyName = 1
        FirstTimeIconLib  = 0
        QuickSearchAutoFilter = 1
    }
    Layout = @{
        ButtonBar  = 0
        DriveBar1  = 1
        DriveBar2  = 1
        DriveCombo = 0
    }
    Colors = @{
        InverseCursor = 1
        BackColor     = 0
        BackColor2    = 0
        ForeColor     = 16777215
        CursorColor   = 14120448
    }
    Shortcuts = @{
        F2    = 'cm_RenameSingleFile'
        'C+F' = 'cm_SearchFor'
    }
} | Set-TCOptions
