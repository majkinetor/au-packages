cd $PSScriptRoot
. .\au.ps1


$options = @{
    Email      = 'miodrag.milic@gmail.com'
    SmtpServer = '10.35.1.36'
}

$r = updateall p* -Wait 0 -Options $options
$r | Export-CliXML update_results.xml

