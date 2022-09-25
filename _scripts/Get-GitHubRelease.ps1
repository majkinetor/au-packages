function Get-GitHubReleaseUrl( $GitHubRepositoryUrl, $Pattern='\.exe$') {
    $latestReleases = "$GitHubRepositoryUrl/releases/latest"
    $latestPage = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $latestPage.Content -match '(?<=src=")[^"]+expanded_assets[^"]+' | Out-Null
    $assetsUrl = $Matches[0]
    if (!$assetsUrl) { throw "Can't find assets URL" }

    $domain  = $GitHubRepositoryUrl -split '(?<=//.+)/' | select -First 1
    $assetsPage = Invoke-WebRequest -Uri $assetsUrl -UseBasicParsing
    $assetsPage.links | ? href -match $Pattern | Select-Object -expand href | % { $domain + $_ }
}