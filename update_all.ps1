cd $PSScriptRoot

. .\au.ps1
$r = updateall -Options @{
    Email      = 'miodrag.milic@gmail.com'
    SmtpServer = '10.35.1.36'
}
$r | Export-CliXML update_results.xml

