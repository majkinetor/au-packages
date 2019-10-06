# [tcps](https://chocolatey.org/packages/tcps)

Powershell scripts to automate [Totall Commander Plugins](https://chocolatey.org/packages?q=tag%3Atcplugin) installation.

## Features

- Supports all plugin types
- Unpacks the plugin
- Installs plugin for Total Commander
- Installs plugin for Double Commander

## Notes

- By default plugins are installed at `$Env:COMMANDER_PLUGINS_PATH`. If not set, it defaults to `$(Get-ToolsLocation)\TCPlugins`
