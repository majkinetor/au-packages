import-module au

$releases = 'https://www.rundeck.com/community-downloads'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
            "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }

        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)([$]url\s*=\s*').*'" = "`${1}$($Latest.URL32)'"
        }
    }
}

function global:au_BeforeUpdate { $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $versionUrl = $download_page.Content -split "`n" | sls "https://www.rundeck.com/community-downloads/[.0-9]+" | select -First 1
    $versionUrl = $versionUrl -split "'" | select -Last 1 -Skip 1

    $download_page = Invoke-WebRequest -Uri $versionUrl -UseBasicParsing
    $url = $download_page.Content -split "`n" | sls "\.war/download" | select -First 1
    $url = $url -split "'" | select -Last 1 -Skip 1
    @{
        Version      = $url -split '-'  | select -First 1 -Skip 1
        URL32        = $url
        ReleaseNotes = $versionUrl
        FileType     = 'war'
    }
}

update -ChecksumFor none
