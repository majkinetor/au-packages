# [tcps](https://chocolatey.org/packages/tcps)

TCP Scripts can be used to automate Total Commander plugin installation. Besides unpacking, scripts will setup or remove plugin for file managers that are found on the local system. Supported file managers are:
- [Total Commander](https://chocolatey.org/packages/totalcmd) (TC) 
- [Double Commander](https://chocolatey.org/packages/doublecmd) (DC)

Both TC and DC are automatically detected if present on the system.

Use the following tags to browse for TC plugins on Chocolatey Community Gallery:

|                                  Tag                                   | TC plugin category |
| ---------------------------------------------------------------------- | ------------------ |
| [tcplugin](https://chocolatey.org/packages?q=tag%3Atcplugin)           | Any                |
| [tcpfilesystem](https://chocolatey.org/packages?q=tag%3Atcpfilesystem) | File System        |
| [tcplister](https://chocolatey.org/packages?q=tag%3Atcplister)         | Lister             |
| [tcpcontent](https://chocolatey.org/packages?q=tag%3Atcpcontent)       | Content            |
| [tcppacker](https://chocolatey.org/packages?q=tag%3Atcppacker)         | Packer             |

## Features

- Supports all plugin types
- Unpacks the plugin
- Installs and remove plugin for Total Commander
- Installs and remove plugin for Double Commander

## Notes

- By default plugins are installed at `$Env:COMMANDER_PLUGINS_PATH`. If not set in the system, it defaults to `$Env:ChocolateyToolsLocation\TCPlugins`
- Plugin installer will close any running instances of TC or DC prior to plugin installation
- **For maintainers**: TCP scripts expect that TC plugin archive is embedded in the package with the file name that *contains* plugin name. The base file name of the plugin itself, once unpacked, must be the same as the name used within Chocolatey installation script. See code and content of existing packages for details.
