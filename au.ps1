
#Returns true if package is updated, false otherwise
function Update-Package {
    [CmdletBinding()]
    param(
        [switch]$AllowTextualUrl
    )

    function Load-NuspecFile() {
        $nu = New-Object xml
        $nu.psbase.PreserveWhitespace = $true
        $nu.Load($nuspecFile)
        $nu
    }

    function check_url($url) {
        if ([string]::IsNullOrWhiteSpace($url)) {throw "URL is empty"}
        try
        {
            $HttpWebRequest = [System.Net.HttpWebRequest]::Create($url)
            $HttpWebResponse = $HttpWebRequest.GetResponse()
            if (!$AllowTextualUrl -and $HttpWebResponse.ContentType -eq 'text/html') { $res = $false; $err='Invalid content type: text/html' }
            $res = $true
        }
        catch {
            $res = $false
            $err = $_
        }

        if (!$res) { throw "Can't validate URL '$url'`n$err" }
    }

    function check_version($Version) {
        $re = '^[\d.]+$'
        if ($Version -notmatch $re) { throw "Version doesn't match the pattern '$re': '$Version'" }
    }

    function check() { check_url $Latest.url; check_version $Latest.version }

    $packageName = Split-Path $pwd -Leaf
    $nuspecFile = Get-Item "$packageName.nuspec" -ea ig
    if (!$nuspecFile) {throw 'No nuspec file' }
    $nu = Load-NuspecFile
    $global:nuspec_version = $nu.package.metadata.version

    "$packageName - checking updates"
    try {
        $global:Latest  = au_GetLatest
    } catch {
        throw "au_GetLatest failed`n$_"
    }
    $latest_version = $Latest.version

    check

    "nuspec version: $nuspec_version"
    "remote version: $latest_version"

    if ($latest_version -eq $nuspec_version) {
        return 'No new version found'
    } else { 'New version is available, updating' }

    'Updating files'
    "  $(Split-Path $nuspecFile -Leaf)"
    "    updating version:  $nuspec_version -> $latest_version"
    $nu.package.metadata.version = "$latest_version"
    $nu.Save($nuspecFile)

    $sr = au_SearchReplace
    $sr.Keys | % {
        $fileName = $_
        "  $fileName"

        $fileContent = Get-Content $fileName
        $sr[ $fileName ].GetEnumerator() | % {
            ('    {0} = {1} ' -f $_.name, $_.value)
            $fileContent = $fileContent -replace $_.name, $_.value
        }

        $fileContent | Out-File -Encoding UTF8 $fileName
    }

    cpack
    return 'Package updated'
}

function Push-Package() {
    $ak = Get-Item api_key -ea 0
    if (!$ak) { $ak = Get-Item ../api_key -ea 0}
    if (!$ak) { throw "File api_key not found in this or parent directory, aborting push" }

    $api_key = Get-Content $ak
    $package = Get-Item *.nupkg | Sort-Object -Property CreationTime -Descending | Select-Object -First 1
    if (!$package) { throw "There is no nupkg file in the directory"}
    cpush $package.Name --api-key $api_key
}

function Get-AUPackages($name) {
    Get-ChildItem .\*\update.ps1 | % {
        $packageDir = Get-Item (Split-Path $_)
        if ($packageDir.Name -like "_*") { return }
        if ($packageDir -like "*$name*") { $packageDir }
    }
}

function Update-AUPackages($name, [switch]$Push, [hashtable]$Options) {
    $cd = $pwd
    $err = $pkg = 0
    "Started updating procedure for all automatic update packages"

    Get-AUPackages $name | % {
        $pkg += 1; $msg = ''; $update_err = $null
        Set-Location $_
        $packageName = Split-Path $_ -Leaf
        try {
            $r = .\update.ps1
            $packageUpdated = $r[-1] -eq 'Package updated'
            $remote_version = ($r -match '^remote version: .+$').Substring(16)

            if ($packageUpdated -and $Push) { push-package }

            if ($packageUpdated) {
                $msg = "{0} is updated to {1}" -f $packageName, $remote_version
                if ($Push) { $msg += " and pushed" }
            }
            else { $msg = "$packageName has no updates" }

        } catch {
            $err+=1
            $update_err = $_
        }

        if ($update_err) { 
            $errmsg = $update_err -split '\n' | % { "  $_" }
            $msg = "$packageName had errors during update"
        }
        $msg
        if ($update_err) {$errmsg}
    }
    Set-Location $cd

    ""
    "="*40
    "Automatic packages: $pkg"
    "Total errors: $err"
}

function Test-Package() {
    cpack
    cinst (Get-Item *.nupkg).Name --source $pwd --force
}


Set-Alias updateall   Update-AuPackages
Set-Alias update      Update-Package
Set-Alias pp          Push-Package
Set-Alias gup         Get-AuPackages
Set-Alias test        Test-Package

Update-AUPackages
