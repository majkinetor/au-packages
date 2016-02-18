cd $PSScriptRoot
. .\au.ps1


$options = @{
    Email      = 'miodrag.milic@gmail.com'
    SmtpServer = '10.35.1.36'
}

$r = updateall dn* -Options $options
$r | Export-CliXML update_results.xml
