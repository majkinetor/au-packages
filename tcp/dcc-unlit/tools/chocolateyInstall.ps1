$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\doublecmd.ps1

$pp = Get-PackageParameters
if (!$pp.IconSize) { $pp.IconSize = 16 }
if (!$pp.FontSize) { $pp.FontSize = 10 }

Write-Host "Setting Double Commander Configuration: $Env:ChocolateyPackageName"
Write-Host "Configurable parameters:"
Write-Host "  Font size: $($pp.FontSize)"
Write-Host "  Icon size: $($pp.IconSize)"
@{ 
    Behaviours = @{
        OnlyOneAppInstance       = $true
        'Mouse.Selection.Button' = 1
        DateTimeFormat           = "yyyy-MM-dd hh:nn:ss"
    }
    Colors = @{
        Foreground  = 16777215
        Background  = 0
        Background2 = 0
    }
    'Fonts.Main' = @{  
        Size = $pp.FontSize      
        Style = 0
    }
    FilesViews = @{
        'BriefView.FileExtAligned' = $true
    }
    FileOperations = @{
        RenameSelOnlyName = $true
    }
    Icons = @{
        Size = $pp.IconSize
        ShowInMenus = @{ Enabled = $true } 
    }
    'Keyboard.Typing.Actions'= @{
        NoModifier = 3
        Alt        = 1
        CtrlAlt    = 0
    }    
    Language = @{
        POFileName = "doublecmd.po"
    }
    Layout = @{
        ButtonBar            = @{ Enabled = $false }
        DrivesListButton     = @{ Enabled = $false }
        DriveFreeSpace       = $false
        ShortFormatDriveInfo = $false
    }
    Miscellaneous = @{
        SpaceMovesDown   = $true
        InplaceRename    = $true
        DblClickToParent = $true
    }
    QuickFilter = @{
        SaveSessionModifications = $false
    }
    QuickSearch = @{
        MatchBeginning  = $false
        MatchEnding     = $false
    }
} | Set-DCOptions
