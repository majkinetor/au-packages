# [![](https://img.shields.io/chocolatey/v/tcp-linkinfo.svg?color=red&label=tcp-linkinfo)](https://chocolatey.org/packages/tcp-linkinfo)

The plugin allows to view LNK files in Total Commander by simply pressing F3.

The following information is shown:

1. Link target
2. Additional command-line arguments
3. Working folder
4. Description (comment)
5. Hotkey
6. Window size
7. Icon (path to the icon file and icon number)

By right-clicking you can open context menu containing the "Edit..." command. It
allows to update the contents of the shortcut file you are viewing.

In addition, the archive contains a stand-alone program for editing LNK files.
When started, it shows the same dialog for editing the shortcut file which can
also be supplied as command-line parameter.

These two parts of project are independent and can work without each other.
It is not necessary to keep LinkEditor with LinkInfo.

See [TCP Scripts](https://chocolatey.org/packages/tcps) for package parameters and other notes.

![screenshot](https://cdn.rawgit.com/majkinetor/chocolatey/master/tcp/tcp-linkinfo/screenshot.png)