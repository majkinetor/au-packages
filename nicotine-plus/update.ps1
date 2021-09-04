$releases = 'https://github.com/nicotine-plus/nicotine-plus/releases'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix

    Set-Alias 7z $Env:chocolateyInstall\tools\7z.exe
    7z e tools\*.zip -otools\* -r -y
    rm tools\*.zip -ea 0
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $domain  = $releases -split '(?<=//.+)/' | select -First 1

    $re      = 'windows-.+?installer\.zip$'
    $url     = $download_page.links | ? href -match $re | select -First 2 -expand href | % { $domain + $_}
    $version = $url[0] -split '/' | select -Last 1 -Skip 1

    @{
        Version      = $version
        URL32        = $url -match 'i686'    | select -First 1
        URL64        = $url -notmatch 'i686' | select -First 1
        ReleaseNotes = "https://github.com/nicotine-plus/nicotine-plus/releases/tag/$version"
    }
}

update -ChecksumFor none
