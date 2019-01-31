import-module au

$releases = 'https://github.com/FiloSottile/mkcert/releases/latest'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { 
    Get-RemoteFiles -Purge 
    mv tools\mkcert*.exe tools\mkcert.exe
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version  = $url -split '-|.exe' | select -Last 1 -Skip 3

    @{
        Version      = $version.Substring(1)
        URL64        = 'https://github.com/' + $url
        ReleaseNotes = "https://github.com/FiloSottile/mkcert/releases/tag/$version"
    }
}

update -ChecksumFor none
