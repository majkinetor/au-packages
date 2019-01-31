import-module au

$releases = "https://launcher.nirsoft.net/downloads/index.html"

function global:au_SearchReplace() {
  @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate  { 
    rm tools\*.zip, tools\*.nlp -ea 0
    $name = Split-Path -Leaf $Latest.URL32
    iwr -Headers @{ Referer = $releases } $Latest.URL32 -OutFile tools\$name
    iwr http://download.nirsoft.net/sysinternals2.nlp -OutFile tools\sysinternals2.nlp

    Write-Host "Removing password"
    $pass = 'nirsoft9876$'

    $zip_file_enc = gi tools\*.zip
    $zip_name_enc = $zip_file_enc.Name -replace '\.zip$'
    $zip_name     = $zip_name_enc -replace '_enc'
    set-alias 7z $Env:chocolateyInstall\tools\7z.exe
    7z x -aoa $zip_file_enc "-p$pass" "-o$zip_name" 
    7z a -aoa tools\$zip_name.zip .\$zip_name\*
    rm $zip_file_enc, $zip_name -Recurse
}

function global:au_GetLatest() {
    try { 
        $download_page = Invoke-WebRequest $releases -UseBasicParsing
    } catch {
        if ($_ -eq 'Unable to connect to the remote server') { 
            Write-Host "Ignoring unknown connection problem with AppVeyor"
            return 'ignore'
        }
        throw $_
    }

    $url     = $download_page.links | ? href -match "nirsoft_package_.*.zip" | select -First 1 -expand href
    $version = $url -split '_|.zip' | select -Last 1 -Skip 1

    @{ Version = $version; URL32 = "https:$url" }
}

update -ChecksumFor none -NoCheckUrl
