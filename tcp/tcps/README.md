# [![](https://img.shields.io/chocolatey/v/tcps.svg?color=red&label=tcps)](https://chocolatey.org/packages/tcps)[tcps](https://chocolatey.org/packages/tcps)

TCP Scripts can be used to automate Total Commander plugin installation. Besides unpacking, scripts will setup or remove plugin for file managers that are found on the local system. Supported file managers are:

- [Total Commander](https://chocolatey.org/packages/totalcommander) (TC)
- [Double Commander](https://chocolatey.org/packages/doublecmd) (DC)
- [Double Commander Dark](https://chocolatey.org/packages/doublecmd.dark) (DC)

Both TC and DC are automatically detected if present on the system.

Use the following tags to browse for TC plugins on Chocolatey Community Gallery:

- [Any TC Plugin (tcplugin)](https://chocolatey.org/packages?q=tag%3Atcplugin)
- [File System (tcpfilesystem)](https://chocolatey.org/packages?q=tag%3Atcpfilesystem)
- [Lister (tcplister)](https://chocolatey.org/packages?q=tag%3Atcplister)
- [Content (tcpcontent)](https://chocolatey.org/packages?q=tag%3Atcpcontent)
- [Packer (tcppacker)](https://chocolatey.org/packages?q=tag%3Atcppacker)

Use the following tags to browse custom DC/TC configuration settings:

- [Double Commander Configs (dcconfig)](https://chocolatey.org/packages?q=tag%3Adcconfig)
- [Total Commander Configs (tcconfig)](https://chocolatey.org/packages?q=tag%3Atcconfig)

## Features

- Supports all plugin types
- Unpacks the plugin
- Installs and removes plugin for Total Commander
- Installs and removes plugin for Double Commander
- Set TC & DC options

## Notes

- By default plugins are installed at `$Env:COMMANDER_PLUGINS_PATH`. If not set in the system, it defaults to `$Env:ChocolateyToolsLocation\TCPlugins`
- Plugin installer will close any running instances of TC or DC prior to plugin installation
- Plugin installer will setup up either x32 or x64 bit plugin version, but not both

## Using

To use the functions, depend on this package and import `tcps.ps1` like this:

```
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\tcps.ps1
```

After that simply call `Install-TCPlugin` or `UnInstall-TCPlugin` with plugin name as a parameter and it will take care of everything. Note that you must define `$toolsPath` as it is used to find out embedded TC plugin path.

TCP scripts expect that TC plugin archive is embedded in the package with the file name that *contains* plugin name. The base file name of the plugin itself, once unpacked, must be the same as the name used within Chocolatey installation script. See code and content of existing packages for details.

For example:

- TC plugin name : `FileInfo`
- Embedded archive file name: `wlx_fileinfo223.zip`
- TC Plugin name (unpacked): `$Env:COMMANDER_PLUGINS_PATH\...\fileinfo.wlx[64]`

Scripts `totalcmd.ps1` and `doublecmd.ps1` handle plugin operations for respective file managers and can be used standalone.
