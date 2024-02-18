import-module au

$releases = 'https://eraser.heidi.ie/download'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase "Eraser $($Latest.Version)" }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '\.exe/download'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url -split '%20|.exe' | select -Last 1 -Skip 1

    @{
        Version      = $version
        URL32        = $url -replace '\?.+'
        FileType     = 'exe'
    }
}

update -ChecksumFor none
