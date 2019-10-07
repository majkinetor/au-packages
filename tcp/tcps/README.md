# [tcps](https://chocolatey.org/packages/tcps)

Powershell scripts to automate [Totall Commander Plugins](https://chocolatey.org/packages?q=tag%3Atcplugin) installation.
Scripts can be used to automate plugin installation and eventually setup and removal for file managers [Total Commander](https://chocolatey.org/packages/totalcmd) (TC) and [Double Commander](https://chocolatey.org/packages/doublecmd) (DC).

Both TC and DC are automatically detected if present on the system.

## Features

- Supports all plugin types
- Unpacks the plugin
- Installs and remove plugin for Total Commander
- Installs and remove plugin for Double Commander

## Notes

- By default plugins are installed at `$Env:COMMANDER_PLUGINS_PATH`. If not set in the system, it defaults to `$Env:ChocolateyToolsLocation\TCPlugins`
- Plugin installer will close any running instances of TC or DC prior to plugin installation
- Use the following tags to browse for TC plugins on Chocolatey Community Gallery:

    |                                  Tag                                   | TC plugin category |
    | ---------------------------------------------------------------------- | ------------------ |
    | [tcplugin](https://chocolatey.org/packages?q=tag%3Atcplugin)           | Any                |
    | [tcpfilesystem](https://chocolatey.org/packages?q=tag%3Atcpfilesystem) | File System        |
    | [tcplister](https://chocolatey.org/packages?q=tag%3Atcplister)         | Lister             |
    | [tcpcontent](https://chocolatey.org/packages?q=tag%3Atcpcontent)       | Content            |
    | [tcppacker](https://chocolatey.org/packages?q=tag%3Atcppacker)         | Packer             |