$ErrorActionPreference = 'Stop'

$root = Split-Path -parent $MyInvocation.MyCommand.Definition
$is64bit = Get-ProcessorBits -eq '64'

"Installing $(Get-ProcessorBits) bit version"
if ($is64bit) { rm -r -force $root\x86 } else { rm -r -force $root\x64 }
