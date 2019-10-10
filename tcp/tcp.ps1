Write-Host "Generating nupkg fils for all packages"
ls $PSScriptRoot -Directory | % {
    if ($_.Name -in 'dcp','tcp') {return}
    Write-Host -Foreground yellow $_
    pushd $_
        rm *.nupkg
        cpack | Out-Null
        if ($_ -eq 'tcps') {
            $n = gi tcps*.nupkg
            $_n = $n.Name -replace '^', '_'
            mv $n $_
        }
        cp *.nupkg $PSScriptRoot
        cp *.nupkg C:\Work\chocolatey-test-environment\packages
    popd
}