import-module au
. $PSScriptRoot\update_helpers.ps1

$releases = 'https://www.enterprisedb.com/downloads/postgres-postgresql-downloads'
$domain   = $releases -split '(?<=//.+)/' | select -First 1

function global:au_SearchReplace {
    if ($Latest.PackageName -eq 'postgresql') {
        return @{
            ".\postgresql.nuspec" = @{
                "\<dependency .+?/>" = '<dependency id="{0}" version="[{1}]" />' -f $Latest.Dependency, $Latest.Version
                "\<file .+?/>"       = '<file src="tools\*.dummy" target="tools" />'
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
            "\<dependency .+?/>" = '<dependency id="chocolatey-core.extension" version="1.3.3" />'               
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
    $table = Get-WebRequestTable $download_page "postgres-download-matrix"

    $streams = [ordered]@{}
    foreach ($item in $table) {
        $version = $item."PostgreSql Version" -replace '\s*\(.+'
        $v = [version]$version
        $major = $v.ToString(1)

        $s1 = @{
            Version      = $version
            Url64        = Resolve-PostgreUrl $item."Windows x86-64"
            Url32        = Resolve-PostgreUrl $item."Windows x86-32"
            PackageName  = "postgresql$major"
            ReleaseNotes = "https://www.postgresql.org/docs/$major/static/release.html"
            SoftwareName = "PostgreSQL $major*"
        }

        $s2 = @{
            Version     = $version
            Dependency  = $s1.PackageName
            PackageName = 'postgresql'
        }
        if (!$s1.Url64 -and !$s1.Url32) { continue }
        if (!$s1.Url64) { $s1.Remove("Url64") }
        if (!$s1.Url32) { $s1.Remove("Url32") }
        
        $s = $v.ToString(2);   $streams.$s = $s1
        $s = $s2.Dependency;   $streams.$s = $s2
    }
    
    $streams.postgresql = @{ 
        Version     = $streams[0].Version
        Dependency  = $streams[0].PackageName
        PackageName = 'postgresql'
    }

    @{ streams = $streams }
}

update -ChecksumFor none
