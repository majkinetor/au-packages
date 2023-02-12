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

function Resolve-PostgreUrl([string] $url) {
    if ($url.EndsWith('.exe')) { return $url }

    $params = @{
        MaximumRedirection = 0
        Uri = $url
        ErrorAction = 'ignore'
    }
    $url = try { Invoke-WebRequest @params | % Headers | % Location } catch { $_.Exception.Response.Headers.Location.OriginalString }
    $url
}
