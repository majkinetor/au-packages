# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/mp3directcut/icon.png" width="48" height="48"/> [![](https://img.shields.io/chocolatey/v/mp3directcut.svg?color=red&label=mp3directcut)](https://chocolatey.org/packages/mp3directcut)

mp3DirectCut is a fast and extensive audio editor and recorder for encoded MP3. Without re-encoding you can directly cut, crop or split your MP3 and AAC tracks, change the volume on MP3 and much more. Direct editing saves encoding time and preserves the original audio quality of your tracks. The built in recorder creates MP3 on the fly. By using Cue sheets, Pause detection or Auto cue you can easily divide long files.

## Features

- Direct data copying, no re-encoding 
- Non-destructive cut, copy, paste 
- Volume change, fading, normalizing for MP3 
- MP3 recording/encoding with ACM or Lame 
- Fast MPEG visualisation and easy navigation 
- AAC support, MP2 support 
- Batch processing, Cue Sheet support 
- Pause detection, Auto cue by time values 
- Track splitting with filename and tag creation 
- Trim, Crop, Fast play, Loop play 
- ID3v1.1 tag editor, ID3v2 tag keeping 
- VU meter, bitrate visualisation 
- Command line usage, Unicode support 

## Notes

- Optional requirements:
    - For AAC play: [libfaad2.dll](http://www.rarewares.org/files/aac/libfaad2-2.7.zip) (32 bit)
    - For MP3 recording: encoding ACM or Lame encoder DLL (32 bit): `choco install lame`
    - For MP4 demuxing: ffmpeg.exe: `choco install ffmpeg`

![screenshot](https://github.com/majkinetor/au-packages/raw/master/mp3directcut/screenshot.jpg)
