Start-Transcript -Append $PSScriptRoot\update_all.log

$packages = ls *\update.ps1 -Exclude _*
pushd

"Updating all packages`n"
if (Test-Path api_key) { $api_key = (gc ..\api_key) } else { "File api_key not found, updated packages will not be pushed" }
$packages | % {
    cd (Split-Path $_ -Parent)
    "-"*80
    Split-Path (Split-Path $_ -Parent) -Leaf
    "-"*80
    & "$_" | tee -Variable updated

    $updated = $updated[-1] -eq 'Package updated'
    if ($updated){
        rm *.nupkg
        cpack

        $package = (gi *.nupkg).Name
        if ($api_key) { cpush $package --api-key $api_key }
    }
}

popd

Stop-Transcript
