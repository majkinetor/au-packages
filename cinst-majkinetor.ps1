<# Installs package directly from Github repository
 To use with your own repo: 
   - Rename the function to contain your Github name
   - Set the path to your packages root in $Repo 
   - Create short link, via for example goo.gl

 Example: iwr https://goo.gl/0aP4PK | iex; cinst-majkinetor furmark
 Example: cinst-majkinetor furmark
#>
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
