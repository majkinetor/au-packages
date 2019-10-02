import-module au

$releases = 'https://github.com/rapidloop/pgmetrics/releases/latest'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { 
    Get-RemoteFiles -Purge -NoSuffix 
    
    Set-Alias 7z $Env:chocolateyInstall\tools\7z.exe
    7z e tools\*.zip -otools *.exe -r -y
    rm tools\*.zip -ea 0
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '\.zip$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $domain  = $releases -split '(?<=//.+)/' | select -First 1
    $version = ($url -split '/' | select -Last 1 -Skip 1).Substring(1)

    @{
        Version      = $version
        URL32        = $domain + $url
        ReleaseNotes = "https://github.com/rapidloop/pgmetrics/releases/tag/v${version}"
    }
}

update -ChecksumFor none
