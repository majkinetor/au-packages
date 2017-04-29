$ErrorActionPreference = 'Stop'

Uninstall-BinFile 'plantuml'
rm $Env:USERPROFILE\Desktop\plantuml.lnk -ea 0