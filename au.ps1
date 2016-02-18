
#Returns true if package is updated, false otherwise
function Update-Package {
    [CmdletBinding()]
    param(
    )

    function Load-NuspecFile() {
        $nu = New-Object xml
        $nu.psbase.PreserveWhitespace = $true
        $nu.Load($nuspecFile)
        $nu
    }

    function check_url() {
        $Latest.Keys | ? {$_ -like 'url*' } | % {
            $url = $Latest[ $_ ]
            if ([string]::IsNullOrWhiteSpace($url)) {throw 'URL is empty'}
            try
            {
                $HttpWebRequest = [System.Net.HttpWebRequest]::Create($url)
                $HttpWebResponse = $HttpWebRequest.GetResponse()
                if ($HttpWebResponse.ContentType -like '*text/html*') { $res = $false; $err='Invalid content type: text/html' }
                else { $res = $true }
            }
            catch {
                $res = $false
                $err = $_
            }

            if (!$res) { throw "Can't validate URL '$url'`n$err" }
        }
    }

    function check_version() {
        $re = '^[\d.]+$'
        if ($Latest.Version -notmatch $re) { throw "Version doesn't match the pattern '$re': '$Version'" }
    }

    function check() { check_url; check_version}

    $packageName = Split-Path $pwd -Leaf
    $nuspecFile = gi "$packageName.nuspec" -ea ig
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

        $fileContent = gc $fileName
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
    $ak = gi api_key -ea 0
    if (!$ak) { $ak = gi ../api_key -ea 0}
    if (!$ak) { throw 'File api_key not found in this or parent directory, aborting push' }

    $api_key = gc $ak
    $package = ls *.nupkg | sort -Property CreationTime -Descending | select -First 1
    if (!$package) { throw 'There is no nupkg file in the directory'}
    cpush $package.Name --api-key $api_key
}

function Get-AUPackages($name) {
    ls .\*\update.ps1 | % {
        $packageDir = gi (Split-Path $_)
        if ($packageDir.Name -like '_*') { return }
        if ($packageDir -like "*$name*") { $packageDir }
    }
}

function Update-AUPackages($name, [switch]$Push, [hashtable]$Options) {
    $cd = $pwd
    Write-Host 'Updating all automatic packages'

    $result = @()
    $a = Get-AUPackages $name
    $a | % {
        $i = [ordered]@{PackageName=''; Updated=''; RemoteVersion=''; NuspecVersion=''; Message=''; Result=''; PushResult=''}

        Set-Location $_
        $i.PackageName = Split-Path $_ -Leaf
        try {
            $i.Result        = .\update.ps1
            $i.Updated       = $i.Result[-1] -eq 'Package updated'
            $i.RemoteVersion = ($i.Result -match '^remote version: .+$').Substring(16)
            $i.NuspecVersion = ($i.Result -match '^nuspec version: .+$').Substring(16)

            if ($i.Updated -and $Push) { i.PushResult = push-package }

            if ($i.Updated) {
                $i.Message = '{0} is updated to {1}' -f $i.PackageName, $i.RemoteVersion
                if ($Push) { $i.Message += ' and pushed' }
            }
            else { $i.Message = $i.PackageName + ' has no updates' }

        } catch {
            $i.Error = $_
            $i.Message = $i.PackageName + " had errors during update"
            $i.Error -split '\n' | % { $i.Message += "`n    $_" }
        }
        Write-Host "  $($i.Message)"
        $result += [pscustomobject]$i

    }
    Set-Location $cd

    Write-Host ""
    Write-Host "Automatic packages processed: $($result.Length)"
    Write-Host "Total errors: $( ($result | ? Error -ne $null).Length )"

    $result
}

function Install-AUScheduledTask($At="03:00")
{
    if ([System.Environment]::OSVersion.Version -lt 6.2) { throw "This function can be used only on Windows 8/2012 or newer" }
    import-module ScheduledTasks

    $limit = New-TimeSpan -Hours 1
    $user = "$env:USERDOMAIN\$env:USERNAME"

    $script   = "{ cd $PSScriptRoot; . .\au.ps1; `$r = updateall; `$r | Export-CliXML update_results.xml }"
    $poshArgs = "-NoProfile -Command $script"
    $poshArgs

    $a = New-ScheduledTaskAction -Execute powershell -Argument $poshArgs -WorkingDirectory $pwd
    $t = New-ScheduledTaskTrigger -Daily -At $at
    $s = New-ScheduledTaskSettingsSet -ExecutionTimeLimit $Limit -DontStopIfGoingOnBatteries -AllowStartIfOnBatteries -Compatibility Win8 -StartWhenAvailable

    $params = @{
        Force    = $True
        TaskPath = $user
        Action   = $a
        Trigger  = $t
        Settings = $s
        Taskname = "Update Chocolatey Packages"
    }
    Register-ScheduledTask @params
}

function Test-Package() {
    cpack
    cinst (gi *.nupkg).Name --source $pwd --force
}


Set-Alias updateall   Update-AuPackages
Set-Alias update      Update-Package
Set-Alias pp          Push-Package
Set-Alias gup         Get-AuPackages
Set-Alias test        Test-Package


if ($MyInvocation.CommandOrigin -eq 'Runspace') {
    Install-AUScheduledTask
    #Update-AUPackages
}
