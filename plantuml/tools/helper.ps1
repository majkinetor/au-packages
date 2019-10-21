function Get-JavaPaths {
   if ($Env:JAVA_HOME -and (Test-Path $Env:JAVA_HOME\bin)) {
        [array] $paths = (gi -Path $Env:JAVA_HOME\bin\* -ea 0 -Include java.exe,javaw.exe).FullName
        if ($paths.Count -eq 2) { return $paths } 
   }

   $javaw_path = (gcm javaw.exe -ea 0) | select -First 1 -ExpandProperty Path
   $java_path  = (gcm java.exe -ea 0)  | select -First 1 -ExpandProperty Path

   if (!$javaw_path) { throw "javaw.exe is not on the PATH" }
   
   return $java_path, $javaw_path
}

# Create shortcut in tools directory for Register-Application
function Install-PumlToolsShortcut {
    $params = @{
        ShortcutFilePath = "$toolsPath\plantuml.lnk"
        TargetPath       = $javaw_path
        Arguments        = $java_args
        IconLocation     = "$toolsPath\plantuml.ico"
    }
    Install-ChocolateyShortcut @params

    Register-Application "$toolsPath\plantuml.lnk" plantuml
    Write-Host "Plantuml registered as plantuml"
}

function Install-PumlDesktopShortcuts {
    Write-Host "Creating desktop shortcuts"

    $params = @{
        ShortcutFilePath = "$toolsPath\plantuml.lnk"
        TargetPath       = $javaw_path
        Arguments        = $java_args
        IconLocation     = "$toolsPath\plantuml.ico"
    }

    $params.ShortcutFilePath = "$Env:USERPROFILE\Desktop\Plantuml.lnk"
    Install-ChocolateyShortcut @params 

    $pdfFile = gi $toolsPath\*.pdf
    $params = @{
        ShortcutFilePath = "$Env:USERPROFILE\Desktop\Plantuml Reference.lnk"
        TargetPath       = $pdfFile
    }
    Install-ChocolateyShortcut @params
}

# This binary is for interactive work (returns asap)
function Install-PumlBinaryW {
    $binparams = @{
        name     = "plantuml"
        path     = $javaw_path
        useStart = $true
        command  = """$java_args"""
    }
    Install-BinFile @binparams
}

# This binary is for scripting, it waits for java to return
function Install-PumlBinary {
    $binparams = @{
        name     =  "plantumlc"
        path     = $java_path
        useStart = $false
        command  = """$java_args"""
    }
    Install-BinFile @binparams
}