import-module au

$releases = 'http://guysalias.tk/misc/less/'

function global:au_SearchReplace {
    @{}
}

function global:au_BeforeUpdate {
    $lessdir = "$PSScriptRoot\less-*-win*"
    rm $lessdir -Recurse -Force -ea ignore

    iwr $Latest.URL -OutFile "$PSScriptRoot\less.7z"
    7za x $PSScriptRoot\less.7z

    rm $PSScriptRoot\tools\* -Recurse -Force
    mv $lessdir\* $PSScriptRoot\tools -Force
    rm $lessdir -Recurse -Force -ea ignore
    rm $PSScriptRoot\less.7z -ea ignore
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = 'less-.+win.+\.7z'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version = "$( ($url -split '-' | select -Index 1) / 100 )"
    $url = $releases + $url

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
