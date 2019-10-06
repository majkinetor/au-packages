# [tcp-uninstaller](https://chocolatey.org/packages/tcp-uninstaller)

This plugin allows to view the list of installed applications, view detailed information about each uninstallation entry, launch deinstallation and forcibly delete invalid entries.

TC plugins work for [Total Commander](https://chocolatey.org/packages/totalcmd) or [Double Commander](https://chocolatey.org/packages/doublecmd).

## Features

- 64-bit version.
- Full Unicode support.
- Listing of both 32- and 64-bit uninstallation entries (no matter which TC version is used).
- Options to confirm uninstallation.
- Support background operations.
- Content data fields with basic information about uninstallation entries.
- Option where to store plugin settings.
- When deleting a key, auxiliary keys are also deleted from the registry.
- [More...](http://flint-inc.ru/eng/info/uninstaller64.html)

## Package parameters

- `/NoDC` - Do not update Double Commander config.

## Notes

- The package will install plugin files to `$Env:COMMANDER_PLUGINS_PATH` or `[ToolsLocation]\TCPlugins` if it doesn't exist.

![screenshot](https://cdn.rawgit.com/majkinetor/chocolatey/master/tcp/tcp-uninstaller/screenshot.png)
