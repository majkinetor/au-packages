$packages = ls *\update.ps1 -Exclude _*
pushd

"Updating all packages`n"
$packages | % {
    cd (Split-Path $_ -Parent)
    "---------------------------------------"
    Split-Path (Split-Path $_ -Parent) -Leaf
    "---------------------------------------"
    & "$_" | tee -Variable updated

    $updated = $updated[-1] -eq 'Package updated'
    if ($updated){
        rm *.nupkg
        cpack

        $package = (gi *.nupkg).Name
        cpush $package --api-key (gc ..\api_key)
    }
}

popd


