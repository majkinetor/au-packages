$ErrorActionPreference = 'Stop'

. $Env:ChocolateyInstall\lib\tcps\tools\tcps.ps1

Uninstall-TCPlugin TCMediaInfo -NoRemove
Uninstall-TCPlugin TCMediaInfo -ForceType Wlx
# Above will remove content plugin
# Can't remove lister plugin settings in TC & DC due to tcps limitations
# However, leftover settings for missing plugin wont create any problems.