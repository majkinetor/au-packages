# <img src="https://cdn.rawgit.com/majkinetor/chocolatey/master/cantata/icon100.png" width="48" height="48"/> [cantata](https://chocolatey.org/packages/cantata)

Cantata is a graphical client for MPD. It contains the following features:

Cantata started off as a fork of QtMPC, mainly to provide better KDE integration - by using KDE libraries/classes wherever possible. However, the code (and user interface) is now *very* different to that of QtMPC, and both KDE and Qt (Linux) builds have the same feature set. Also, as of 1.4.0, by default Cantata is built as a Qt-only application (with no KDE dependencies).

Unlike most other MPD clients, Cantata caches a copy of the MPD music library. This is so that it can create a proper hierarchy of artists and albums (where Cantata will use the AlbumArtist tag if found, otherwise it will fallback to the Artist tag), to provide album counts, tracks counts, etc in the browser
views and tooltips, and also to help with copying songs to/from devices.

## Features

- Support for Qt4, Qt5, KDE, MacOSX, and Windows.
- Multiple MPD collections.
- Highly customisable layout.
- Songs grouped by album in play queue.
- Context view to show artist, album, and song information of current track.
- Simple tag editor.
- File organizer - use tags to organize files and folders.
- Ability to calculate ReplyGain tags. (Linux only, and if relevant libraries installed)
- Dynamic playlists.
- Online services; Jamendo, Magnatune, SoundCloud, and Podcasts.
- Radio stream support - with the ability to search for streams via TuneIn, ShoutCast, or Dirble.
- USB-Mass-Storage and MTP device support. (Linux only, and if relevant libraries installed)
- Audio CD ripping and playback. (Linux only, and if relevant libraries installed)
- Playback of non-MPD songs - via simple in-built HTTP server if connected to MPD via a standard socket, otherwise filepath is sent to MPD.
- MPRISv2 DBUS interface.
- Support for KDE global shortcuts (KDE builds), GNOME media keys (Linux only), and standard media keys (via Qxt)
- Ubuntu/ambiance theme integration - including dragging of window via toolbar.
- Basic support for touch-style interface (views are made 'flickable').
- Scrobbling.
- Ratings support.

![screenshot](https://rawgit.com/majkinetor/au-packages/master/cantata/screenshot.png)

