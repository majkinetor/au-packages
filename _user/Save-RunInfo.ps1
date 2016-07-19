function Save-RunInfo {
    "Saving run info"
    $p = $Info.Options.Mail.Password
    $Info.Options.Mail.Password=''

    $Info | Export-CliXML update_info.xml

    $Info.Options.Mail.Password = $p
}
