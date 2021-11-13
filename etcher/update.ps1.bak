import-module au

$releases = 'https://github.com/resin-io/etcher/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = 'Setup.+\.exe$'
    $url   =  $download_page.links | ? href -match $re | select -First 1 | % { "https://github.com" + $_.href }
    $version  = $url -split '/' | select -Last 1 -Skip 1

    @{
        Version = $version.Substring(1)
        URL32   = $url
    }
}

function global:au_BeforeUpdate {
     Get-RemoteFiles -Purge
}

update -ChecksumFor none
