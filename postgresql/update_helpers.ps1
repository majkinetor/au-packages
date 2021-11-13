function Get-WebRequestTable {
    param(
        [Microsoft.PowerShell.Commands.HtmlWebResponseObject] $WebRequest
    )

    $table  = @($WebRequest.ParsedHtml.getElementsByTagName('table'))
    $titles = @()
    $rows   = @($table.Rows)

    foreach($row in $rows)
    {
        $cells = @($row.Cells)
        if($cells[0].tagName -eq "TH"){
            $titles = @($cells | % { ("" + $_.InnerText).Trim() })
            continue
        }
        if(!$titles) { $titles = @(1..($cells.Count + 2) | % { "P$_" }) }

        $resultObject = [Ordered] @{}
        for($counter = 0; $counter -lt $cells.Count; $counter++) {
            $title = $titles[$counter]
            if(!$title) { continue }
            $resultObject[$title] = ("" + $cells[$counter].InnerHtml).Trim()
        }
        [PSCustomObject] $resultObject
    }
}

function Resolve-PostgreUrl($p) {
    $url = "https://www.enterprisedb.com/postgresql-tutorial-resources-training?uuid={0}&campaignId={1}" -f $p.uuid, $p.field_campaign_id
    $download_page = Invoke-WebRequest -Uri $url
    $download_page.Content -match '__NEXT_DATA__.+?>(.+?)</script>' | Out-Null
    $json = $Matches[1] | ConvertFrom-Json
    $url = $json.props.pageProps.downloadUrl


    $params = @{
        MaximumRedirection = 0
        Uri = $url
        ErrorAction = 'ignore'
    }
    if ($host.Version.Major -gt 5) { $params.SkipHttpErrorCheck = $true }

    $url = Invoke-WebRequest @params | % Headers | % Location
    $url
}
