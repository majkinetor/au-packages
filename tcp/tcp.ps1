Write-Host "Generating nupkg fils for all packages"
ls $PSScriptRoot -Directory | % {
    if ($_.Name -in 'dcp','tcp','tcps') {return}
    Write-Host -Foreground yellow $_
    pushd $_
        rm *.nupkg
        cpack | Out-Null
        cp *.nupkg $PSScriptRoot
        cp *.nupkg C:\Work\chocolatey-test-environment\packages
    popd
}