# [![](https://img.shields.io/chocolatey/v/tcp-mediainfo.svg?color=red&label=tcp-mediainfo)](https://chocolatey.org/packages/tcp-mediainfo)

Total Commander content and lister plugins to retrieve an info from the video and audio files.

See [TCP Scripts](https://chocolatey.org/packages/tcps) for package parameters and other notes.

Plugin uses [MediaInfo](http://mediainfo.sourceforge.net) library and support all formats that library support.
Since MediaInfo library can retreive a LOT information from file, plugin is fully customizable and allow to wrap any MediaInfo library's field. By default some most useful fields are already configured and you can instantly start to use plugin. 

## Features

- [Supported audio and video formats](http://mediainfo.sourceforge.net/Support/Formats)
- Content plugin supports data caching using the SQLite database that dramatically increases the retrieval speed in the future
- Provides scripting interpreter to fully customize the output

![screenshot](https://cdn.rawgit.com/majkinetor/chocolatey/master/tcp/tcp-mediainfo/screenshot.png)
