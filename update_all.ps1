$packages = ls *\update.ps1 -Exclude _*
pushd

"Updating all packages`n"
$packages | % {
    cd (Split-Path $_ -Parent)
    "---------------------------------------"
    Split-Path (Split-Path $_ -Parent) -Leaf
    "---------------------------------------"
    & "$_"
}

popd


