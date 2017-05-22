<#
This script implements WhatIf functionality. When you use it, it will 
    - backup a package prior a call to update
    - save updater output to another folder
    - restore an original package after update finishes

Use it by adding a switch parameter to update.ps1 and surrounding update
by backup and restore functions:

    param( [switch]$WhatIf )

    ...
    
    backup 
    update ...
    restore

#>

function backup()  { 
    if (!$WhatIf) { return }
    Write-Warning "WhatIf passed - package files will not be changed"

    $packageName = Split-Path -Leaf $MyInvocation.PSScriptRoot
    $d = "$Env:TEMP\au\$packageName"

    rm $d\* -Recurse -ea 0
    cp . $d\_backup -Recurse 
}

function restore() { 
    if (!$WhatIf) { return }
    
    $packageName = Split-Path -Leaf $MyInvocation.PSScriptRoot
    $d = "$Env:TEMP\au\$packageName"

    cp . $d\_output -Recurse 
    rm .\* -Recurse
    cp $d\_backup\* . -Recurse 

    Write-Warning "Package saved to: $d\_output"
}