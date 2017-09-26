import-module au

$releases = 'https://gitlab.com/gitlab-org/gitlab-runner/raw/master/CHANGELOG.md'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
   }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }
function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = ($download_page.Content -split "`n") -match '^v (.+)$' | select -first 1
    $version = ($version.Substring(2) -replace '\(.+').Trim()

    $cversion = $version
    if ($version -match '-.+') { $cversion = ($cversion -replace '-.+') + $Matches[0].Replace('.', '')}
    @{
        Version  = $cversion
        URL32    = "https://gitlab-runner-downloads.s3.amazonaws.com/v${version}/binaries/gitlab-runner-windows-386.exe"
        URL64    = "https://gitlab-runner-downloads.s3.amazonaws.com/v${version}/binaries/gitlab-runner-windows-amd64.exe"
    }
}

update -ChecksumFor none
