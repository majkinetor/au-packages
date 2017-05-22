
function backup()  { 
    if (!$WhatIf) { return }
    Write-Warning "WhatIf passed - package files will not be changed"

    $packageName = Split-Path -Leaf $MyInvocation.PSScriptRoot
    $d = "$Env:TEMP\au\$packageName"

    rm $d\* -Recurse -ea 0
    cp . $d\_backup -Recurse 
}

function restore() { 
    $packageName = Split-Path -Leaf $MyInvocation.PSScriptRoot
    $d = "$Env:TEMP\au\$packageName"
    
    cp . $d\_output -Recurse 
    rm .\* -Recurse
    cp $d\_backup\* . -Recurse 

    Write-Warning "Package saved to: $d\_output"
}