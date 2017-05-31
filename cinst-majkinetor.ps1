# Installs package directly from repository
# Example: cinst-majkinetor furmark
function cinst-majkinetor {
    param($Name, $Repo = "https://github.com/majkinetor/au-packages/tree/master" )

    $download_page = iwr $Repo/$Name -UseBasicParsing
    $url = $download_page.Links.href -like '*.nupkg'
    $p = $url -split '/' | select -last 1
    
    $raw = $Repo -replace 'github.com', 'rawgit.com' -replace 'tree/'
    iwr "$raw/$(($p -split '\.')[0])/$p" -Out $p
    cinst $p
    rm $p
}
