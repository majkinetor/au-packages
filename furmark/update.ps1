import-module au

$releases = 'https://geeks3d.com/furmark/downloads'

function global:au_SearchReplace {
   @{

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    [System.Net.ServicePointManager]::SecurityProtocol = 3072 -bor 768 -bor [System.Net.SecurityProtocolType]::Tls -bor [System.Net.SecurityProtocolType]::Ssl3
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re = 'Version ([.\d]+)\s+'
    $download_page.Content -match $re
    $version  = $Matches[1]
    $url = $download_page.links | ? href -like '/dl/show/*'  | select -first 1 | % { 'https://geeks3d.com' + $_.href }
    $internal_id = Split-Path -Leaf $Url

    $url32 = (iwr "https://geeks3d.com/dl/get/${internal_id}" -MaximumRedirection 0 -ea 0).Headers.Location

    @{
        Version      = $version
        URL32        = $url32
        FileType     = 'exe'
        Options      = @{ Headers = @{Referer = $url}}
    }
}

update -ChecksumFor none

