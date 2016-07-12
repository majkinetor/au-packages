param($Name)

<#
.SYNOPSIS
    Create a new package from the template

.DESCRIPTION
    This function creates a new package by copying the directory _template which contains desired package basic settings.
#>
function New-Package( $Name, $GithubUser) {
    if ($Name -eq $null) { throw "Name can't be empty" }
    if (Test-Path $Name) { throw "Package with that name already exists" }
    if (!(Test-Path _template)) { throw "Template for the packages not found" }
    cp _template $Name -Recurse

    $nuspec = gc "$Name\template.nuspec"
    rm "$Name\template.nuspec"

    $nuspec = $nuspec -replace '<id>.+',               "<id>$Name</id>"
    $nuspec = $nuspec -replace '<iconUrl>.+',          "<iconUrl>https://cdn.rawgit.com/$GithubUser/chocolatey/master/$Name/icon.png</iconUrl>"
    $nuspec = $nuspec -replace '<packageSourceUrl>.+', "<packageSourceUrl>https://github.com/$GithubUser/chocolatey/tree/master/$Name</packageSourceUrl>"
    $nuspec | Out-File -Encoding UTF8 "$Name\$Name.nuspec"
}

New-Package -Name $Name -GithubUser majkinetor
