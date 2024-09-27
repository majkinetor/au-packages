import-module au
. $PSScriptRoot\update_helpers.ps1

$releases = 'https://www.enterprisedb.com/downloads/postgres-postgresql-downloads'
$domain   = $releases -split '(?<=//.+)/' | select -First 1

function global:au_SearchReplace {

    if ($Latest.PackageName -eq 'postgresql') {
        return @{
            ".\postgresql.nuspec" = @{
                "\<file .+?/>"       = '<file src="tools\*.dummy" target="tools" />'
                "\<dependencies.+" = '<dependencies><dependency id="{0}" version="[{1}]" /></dependencies>'  -f $Latest.Dependency, $Latest.Version
            }
        }
    }

    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.softwareName)'"
        }
        ".\tools\chocolateyUninstall.ps1" = @{
            "(?i)(^\s*[$]softwareNamePattern\s*=\s*)('.*')" = "`$1'$($Latest.softwareName)'"
        }
        ".\postgresql.nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
            "\<file .+?/>" = '<file src="tools\**" target="tools" />'
            "\<dependencies.+" = '<dependencies><dependency id="chocolatey-core.extension" version="1.3.3" /><dependency id="vcredist140" version="14.23.27820" /></dependencies>'
        }
    }
}

function global:au_BeforeUpdate() {
    if ($Latest.PackageName -eq 'postgresql') {return}

    # Generate checksum this way
    Get-RemoteFiles -Purge -NoSuffix
    rm tools\*.exe -ea 0
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $download_page.Content -match '<tr .+</tr>' | Out-Null
    $trs = $Matches[0] -split '</tr>'
    $downloads = foreach ($tr in $trs) {
        $tds = $tr -split '</td>'

        $version = $tds[0] -split '>' | select -Last 1
        $version = $version.Replace('*', '')

        $tds[4] -match "href='(.+?)'" | Out-Null
        $href = $Matches[1]

        [PSCUstomObject]@{ version = $version; href = $href }
    }

    $streams = [ordered]@{}
    foreach ($item in $downloads) {
        $major, $minor = $item.version -split '\.|-' | select -First 2
        if ($major -le 12) { continue }
        if (!$major) { continue }
        if (!$minor) { $minor = '0'; $item.version += '.0' }


        $s1 = @{
            Version      = $item.version
            Url64        = Resolve-PostgreUrl $item.href
            PackageName  = "postgresql$major"
            ReleaseNotes = "https://www.postgresql.org/docs/$major/static/release.html"
            SoftwareName = "PostgreSQL $major*"
        }

        $s2 = @{
            Version     = $item.version
            Dependency  = $s1.PackageName
            PackageName = 'postgresql'
        }

        $s = "$major.$minor"
        if ($s -eq '.') { continue }

        $streams.$s = $s1
        $s = "postgresql-$s";  $streams.$s = $s2
    }

    $streams.postgresql = @{
        Version     = $streams[0].Version
        Dependency  = $streams[0].PackageName
        PackageName = 'postgresql'
    }
    @{ streams = $streams }
}

update -ChecksumFor none
