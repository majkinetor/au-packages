import-module au

$releases = 'https://www.xdlab.ru/en/download.htm'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            '(?i)(^\s*file\s*=\s*)(".*")'   = "`$1`"`$toolsPath\$($Latest.FileName32)`""
            '(?i)(^\s*file64\s*=\s*)(".*")' = "`$1`"`$toolsPath\$($Latest.FileName64)`""
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"          
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $domain  = $releases -split '(?<=//.+)/' | select -First 1

    $re       = '\.exe$'
    $url      = $download_page.links | ? href -match $re | select -First 2 -expand href | % { $domain + $_}
    $version  = $url[0] -split '-' | select -Last 1 -Skip 1

    @{
        Version = $version
        URL32   = $url -notmatch '_x64-' | select -First 1
        URL64   = $url -match '_x64-'    | select -First 1
    }
}

update -ChecksumFor none
