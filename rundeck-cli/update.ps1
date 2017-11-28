import-module au

$releases = 'https://github.com/rundeck/rundeck-cli/releases'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { 
    rm $PSScriptRoot\tools\* -Recurse -ea 0 -Exclude *.ps1
    Get-RemoteFiles -NoSuffix 

    set-alias 7z $Env:chocolateyInstall\tools\7z.exe
    
    $rdzip = gi $PSScriptRoot\tools\*.zip
    7z x $rdzip -otools
    rm $rdzip
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = '\.zip$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version  = $url -split '-|\.zip' | select -Last 1 -Skip 1

    @{
        Version = $version
        URL32   = 'https://github.com' + $url
    }
}

update -ChecksumFor none
