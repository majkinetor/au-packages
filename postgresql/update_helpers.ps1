function Get-WebRequestTable {
    param(
        [Microsoft.PowerShell.Commands.HtmlWebResponseObject] $WebRequest,
        [string] $TableClass
    )

    $table  = @($WebRequest.ParsedHtml.getElementsByClassName($TableClass))
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

function Resolve-PostgreUrl($url) {
    if ($URL -eq 'N/A') { return }

    $url -match '(?<=href=").+?(?=")' | Out-Null
    $url = $domain + $Matches[0]
    $p = iwr $url -UseBasicParsing
    $p.Content -match 'download_link":"(https:\\.+?getfile.jsp\?fileid=\d+)' | Out-Null
    if (!$Matches[1]) { return }
    $url = $Matches[1].Replace("\/","/")

    iwr -MaximumRedirection 0 $url -ea 0 | % Headers | % Location
}
