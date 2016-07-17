function Save-RunInfo {
    "Saving run info"
    $Info | Export-CliXML update_info.xml
}
