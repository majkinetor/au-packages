$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\doublecmd.ps1

$pp = Get-PackageParameters
if (!$pp.IconSize) { $pp.IconSize = 20 }
if (!$pp.FontSize) { $pp.FontSize = 10 }

Write-Host "Setting Double Commander Configuration: $Env:ChocolateyPackageName"
Write-Host "Configurable parameters:"
Write-Host "  Font size: $($pp.FontSize)"
Write-Host "  Icon size: $($pp.IconSize)"

Set-DCOptions @{ 
    Behaviours = @{
        OnlyOneAppInstance       = $true
        'Mouse.Selection.Button' = 1
        DateTimeFormat           = "yyyy-MM-dd hh:nn:ss"
    }
    Colors = @{
        Foreground  = 16777215
        Background  = 0
        Background2 = 0
        Cursor      = 12639424        
        Mark        = 255

        UseInvertedSelection = $true
        UseFrameCursor       = $true
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
}

Set-DCHotkey @(
    @{ 
        Shortcut_ = 'Ctrl+F'
        Command = 'cm_Search'
    }
)

Set-DCTemplates @(
    @{
        Name_      = 'Executables'
        FilesMasks = '.exe;*.bat;*.cmd;*.com;*.ps1'
        Color      = 11599871
    },
    @{
        Name_      = 'Documents'
        FilesMasks = '*.rtf;*.tex;*.wps;*.txt;*.doc;*.docx;*.pdf;*.epub;*.md;README'
        Color      = 12639424
    },
    @{  
        Name_      = 'Archives'
        FilesMasks = '*.zip;*.7z;*.rar;*.tar;*.pkg;*.cbr;*.deb'
        Color      = 4227327
    },
    @{  
        Name_       = 'Images'
        FilesMasks  = '*.gif;*.jpg;*.png;*.bmp;*.tiff;*.webp;*.psd;*.tga;*.tif;*.yuv;*.ico'
        Color       = 15780518
    },
    @{  
        Name_       = 'Audio'
        FilesMasks  = '*.mid;*.mpa;*.mp3;*.flac;*.ogg;*.cda;*.wma;*.m4a;*.aac;*.aif;*.aiff;*.wav;'
    }
    @{  
        Name_       = 'Video'
        FilesMasks  = '*.mkv;*.avi;*.m3u;*.mpg;*.mpeg;*.mov;*.m2ts;*.rm;*.vob;*.mp4;*.flv;*.3gp'
    }
)
