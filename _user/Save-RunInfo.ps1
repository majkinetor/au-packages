function save-runinfo {
    "Saving run info"
    $Info | Export-CliXML update_info.xml
}
