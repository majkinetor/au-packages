$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$is64      = (Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true'

if ($is64) { Remove-Item $toolsPath\XiMpLe_x32.exe } else { Remove-Item $toolsPath\XiMpLe_x64.exe  }
Move-Item $toolsPath\XiMpLe_*.exe $toolsPath\XiMpLe.exe

$sparams = @{
    ShortcutFilePath = "$Env:USERPROFILE\Desktop\XiMpLe.lnk"
    TargetPath       = "$toolsPath\XiMpLe.exe"
}
Install-ChocolateyShortcut @sparams
