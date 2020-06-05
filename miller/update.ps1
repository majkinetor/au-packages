import-module au

$releases = 'https://github.com/johnkerl/miller/releases/latest'

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
    $dllName = (Split-Path -Leaf $Latest.URL64).Replace('.dll', '')
    Move-Item tools\$dllName.exe tools\$dllName.dll
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '\.(exe|dll)$'
    $domain  = $releases -split '(?<=//.+)/' | select -First 1
    $url     = $download_page.links | ? href -match $re | select -First 2 -expand href | % { $domain + $_}
    $version = $url -split '/' | select -Last 1 -Skip 1

    @{
        Version      = $version.SubString(1)
        URL32        = $url | ? { $_ -like '*.exe' } | select -First 1
        URL64        = $url | ? { $_ -like '*.dll' } | select -First 1
        ReleaseNotes = "https://github.com/johnkerl/miller/releases/tag/$version"
    }
}

update -ChecksumFor none
