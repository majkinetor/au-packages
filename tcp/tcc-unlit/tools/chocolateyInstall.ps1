$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\totalcmd.ps1

$pp = Get-PackageParameters
if (!$pp.FontSize) { $pp.FontSize = 10 }

Write-Host "Setting Total Commander Configuration: $Env:ChocolateyPackageName"
Write-Host "Configurable parameters:"
Write-Host "  Font size: $($pp.FontSize)"

Set-TCOptions @{
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
        SortDirsByName = 0
        StartupScreen = 0
        DarkMode = 1
    }
    Layout = @{
        ButtonBar  = 0
        DriveBar1  = 1
        DriveBar2  = 1
        DriveCombo = 0
    }
    Colors = @{        
        ForeColor     = 16777215
        BackColor     = 0
        BackColor2    = 0
        MarkColor     = 255        
        CursorColor   = 14120448
        CursorText    = 0

        InverseCursor    = 0
        InverseSelection = 1
    }
    Shortcuts = @{
        F2    = 'cm_RenameSingleFile'
        'C+F' = 'cm_SearchFor'
    }
}

Set-TCTemplates @(
    @{
        Name       = 'Executables'
        FilesMasks = '*.exe;*.bat;*.cmd;*.com;*.ps1'
        Color      = 11599871
    },
    @{
        Name       = 'Documents'
        FilesMasks = '*.rtf;*.tex;*.wps;*.txt;*.doc;*.docx;*.pdf;*.epub;*.md;README'
        Color      = 12639424
    },
    @{  
        Name       = 'Archives'
        FilesMasks = '*.zip;*.7z;*.rar;*.tar;*.pkg;*.cbr;*.deb'
        Color      = 4227327
    },
    @{  
        Name        = 'Images'
        FilesMasks  = '*.gif;*.jpg;*.png;*.bmp;*.tiff;*.webp;*.psd;*.tga;*.tif;*.yuv;*.ico'
        Color       = 15780518
    },
    @{  
        Name        = 'Audio'
        FilesMasks  = '*.mid;*.mpa;*.mp3;*.flac;*.ogg;*.cda;*.wma;*.m4a;*.aac;*.aif;*.aiff;*.wav;'
    },
    @{  
        Name        = 'Video'
        FilesMasks  = '*.mkv;*.avi;*.m3u;*.mpg;*.mpeg;*.mov;*.m2ts;*.rm;*.vob;*.mp4;*.flv;*.3gp'
    }
)
