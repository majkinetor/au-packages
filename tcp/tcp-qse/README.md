# [![](https://img.shields.io/chocolatey/v/tcp-qse.svg?color=red&label=tcp-qse)](https://chocolatey.org/packages/tcp-qse)

Total Commander plugin that extends quick search funtionality.

The main feature is that the search string is divided in substrings at each space. A file matches the search string if all substrings are found in it. You can use the char `|` to find either the string to the left or the string to the right. Use the char `!` in front of a search string to invert the result list.

## Features

- Search substrings in random order
- RegEx search
- Similarity search
- Possibility to use presets
- PinYin support
- Highly customizable

## Notes

- For best experience set Configuration -> Quick Search to `Letters -with search dialog`
- Run `& $Env:COMMANDER_PATH\tcmatch64.exe` to set up the plugin
- Run `& $Env:COMMANDER_PATH\tcmatch.pdf` to see plugin documentation


![screenshot](https://cdn.rawgit.com/majkinetor/chocolatey/master/tcp/tcp-qse/screenshot.png)

