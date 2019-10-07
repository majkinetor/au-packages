# [tcps](https://chocolatey.org/packages/tcps)

TCP Scripts can be used to automate Total Commander plugin installation. Besides unpacking, scripts will setup or remove plugin for file managers that are found on the local system. Supported file managers are:

- [Total Commander](https://chocolatey.org/packages/totalcmd) (TC) 
- [Double Commander](https://chocolatey.org/packages/doublecmd) (DC)

Both TC and DC are automatically detected if present on the system.

Use the following tags to browse for TC plugins on Chocolatey Community Gallery:

- [Any TC Plugin](https://chocolatey.org/packages?q=tag%3Atcplugin)
- [File System](https://chocolatey.org/packages?q=tag%3Atcpfilesystem)
- [Lister](https://chocolatey.org/packages?q=tag%3Atcplister)
- [Content](https://chocolatey.org/packages?q=tag%3Atcpcontent)
- [Packer](https://chocolatey.org/packages?q=tag%3Atcppacker)

## Features

- Supports all plugin types
- Unpacks the plugin
- Installs and remove plugin for Total Commander
- Installs and remove plugin for Double Commander

## Notes

- By default plugins are installed at `$Env:COMMANDER_PLUGINS_PATH`. If not set in the system, it defaults to `$Env:ChocolateyToolsLocation\TCPlugins`
- Plugin installer will close any running instances of TC or DC prior to plugin installation

### Maintainer notes

To use the functions, depend on this package and import `tcps.ps1` like this:

```ps1
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $Env:ChocolateyInstall\lib\tcps\tools\tcps.ps1
```

After that simply call `Install-TCPlugin` or `UnInstall-TCPlugin` with plugin name as a parameter and it will take care of everything. Note that you must define `$toolsPath` as it is used to find out embedded TC plugin path.

TCP scripts expect that TC plugin archive is embedded in the package with the file name that *contains* plugin name. The base file name of the plugin itself, once unpacked, must be the same as the name used within Chocolatey installation script. See code and content of existing packages for details.

For example:

- TC plugin name : `FileInfo`
- Embedded archive file name: `wlx_fileinfo223.zip`
- TC Plugin name (unpacked): `$Env:COMMANDER_PLUGINS_PATH\...\fileinfo.wlx[64]`
