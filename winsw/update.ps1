import-module au

$releases = 'https://github.com/winsw/winsw/releases'

function global:au_SearchReplace {

    if ($Latest.Stream -eq 'winsw') {
        @{
            "$($Latest.PackageName).nuspec" = @{
                "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
                "(\<files\>).*?(\</files\>)"               = "<files></files>"
                "(\<dependencies\>).*?(\</dependencies\>)" = "<dependencies><dependency id='winsw.portable' version='[$($Latest.Version)]'/></dependencies>"
            }
        }
    } else {
        @{
            "$($Latest.PackageName).nuspec" = @{
                "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
                "(\<dependencies\>).*?(\</dependencies\>)" = "<dependencies></dependencies>"
                "(\<files\>).*?(\</files\>)"               = '<file src="tools\**" target="tools" /><file src="legal\**" target="legal" />'
            }

            ".\legal\VERIFICATION.txt" = @{
                "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
                "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
                "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
                "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
            }
        }
    }
}

function global:au_BeforeUpdate {
    if ($Latest.Stream -eq 'winsw') { return }

    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re        = 'WinSW\..+\.zip$'
    $domain    = $releases -split '(?<=//.+)/' | select -First 1
    $url       = $download_page.links | ? href -match $re | select -expand href -First 2 | % { $domain + $_ }
    $version   = $url[0] -split '/' | select -Last 1 -Skip 1
    $nuversion = $version.Substring(1) -replace '(?<=-.+)\.'

    @{ streams = [ordered]@{
        'winsw' = @{
            Version      = $nuversion
            ReleaseNotes = "https://github.com/winsw/winsw/releases/tag/$version"
            PackageName  = 'winsw'
        }
        'winsw.portable' = @{
            Version      = $nuversion
            URL32        = $url -like '*.x86.*' | select -First 1
            URL64        = $url -notlike '*.x86.*' | select -First 1
            ReleaseNotes = "https://github.com/winsw/winsw/releases/tag/$version"
            PackageName  = 'winsw.portable'
        }
    }}
}

update -ChecksumFor none
