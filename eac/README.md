# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/eac/icon.png" width="48" height="48"/> [![](https://img.shields.io/chocolatey/v/eac.svg?color=red&label=eac)](https://chocolatey.org/packages/eac)

Exact Audio Copy is a audio grabber for audio CDs using standard CD and DVD-ROM drives. It works with a technology which reads audio CDs almost perfectly. If there are any errors that can’t be corrected, it will tell you on which time position the (possible) distortion occurred, so you could easily control it with e.g. the media player.

## Features

- All kinds of CD and DVD drives are supported (including USB, Firewire, SATA and SCSI drives)
- Hidden sector synchronization (jitter correction)
- A secure, a fast and a burst extraction methods selectable. Fast extraction should run at the same speed as other grabbers with jitter correction, but is probably not exact anymore. Burst mode just grabs the audio data without any synchronization.
- Detection of read errors and complete losses of sync and correction in the secure mode, as far as possible
- Output of time positions of all non-exact corrections and the possibility to listen to these positions
- EAC is able to copy ranges of music data, not only tracks
- Automatic speed reduction on read errors and fallback to a higher speed afterwards (depends on the used drive)
- Volume normalization of extracted audio to a given percentage
- Usage of the Windows Audio Compression manager (ACM Codecs) for direct compression to e.g. MP3 waves
- Support for the LAME DLL that is usable like an ACM Codec for on-the-fly MP3 compression
- Support of external MP3, WMA, flac and OggVorbis encoders for automatic compression after extraction (supports multi-processor environments)
- Batch compression to WAV files and decompression of supported encoded files to WAV
- Compression offset support for exact compression/decompression
- Detection of pre-track gaps (positions where negative track times runs towards 00:00:00)
- Detection of silence in pre-track gaps
- Automatic creation of CUE sheets for Burnnn, Feurio, Nero or even EAC, which can include all gaps, indicies, track attributes, UPC and ISRC and also CD-Text for an exact copy
- CD player functionality and prelistening to selected ranges
- Automatic detection of drive features, whether a drive has an accurate stream and/or does caching
- Sample offsets for drives with noaccurate streams, including the option of filling up missing samples with silence
- Synchronizing between tracks for non-accurate stream drives
- Trackname editing with local/remote CD databases support and more features like ID3 tagging
- Browse and edit local database
- Certified Escient ® CDDB(TM)Compatible
- Local CDDB support
- Record and loop record functions for recording from LP, radio, etc.
- Automatic renaming of MP3 files accordingto their ID3 tag
- Catalog extraction function (e.g. first 20 seconds of a track)
- Multisession (CD-Extra) support
- CD-Text support
- CD-Write support for some drives (internally and using CDRDAO)
- ID3 V1.1 tag editor with drag and drop ability from track listing and CD database browser
- Glitch removal after extraction
- Small WAV editor with the following functionality: delete, trim, normalize, pad, glitch removal, pop detection, interpolation of ranges, noise reduction, fade in/out, undo (and much more)
- Program is free for personal use, so feel free to copy

![screenshot](https://cdn.rawgit.com/majkinetor/chocolatey/master/eac/screenshot.png)
