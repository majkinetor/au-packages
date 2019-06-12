# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/ansifilter/icon.png" width="48" height="48"/> [![](https://img.shields.io/chocolatey/v/ansifilter.svg?color=red&label=ansifilter)](https://chocolatey.org/packages/ansifilter)

ANSI codes are commands embedded in a text stream to add formatting instructions into this text. These codes are interpreted by terminal emulators like xterm or Putty.

Ansifilter parses common ANSI codes to remove them or to convert them to another colored text file format (HTML, TeX, LaTeX, RTF, Pango or BBCode).
Support for ANSI art files (based on codepage 437 and ANSI.SYS sequences or BIN/XBIN/TND files) is enabled with the --art-cp437, --art-bin and --art-tundra options.

The utility is also available as command line interface.

## Features

```
File handling:
  -i, --input=<file>     Name of input file
  -o, --output=<file>    Name of output file
  -O, --outdir<dir>      Name of output directory
  -t, --tail             Continue reading after end-of-file (like tail -f)

Output text formats:
  -T, --text (default)   Output text
  -H, --html             Output HTML
  -M, --pango            Output Pango Markup
  -L, --latex            Output LaTeX
  -P, --tex              Output Plain TeX
  -R, --rtf              Output RTF
  -B, --bbcode           Output BBCode

Formatted text options:
  -a, --anchors          Add HTML line anchors (assumes -l)
  -d, --doc-title        Set HTML/LaTeX document title
  -e, --encoding         Set HTML encoding (must match input file encoding)
  -f, --fragment         Omit HTML header and footer
  -F, --font=<font>      Set HTML/RTF font face
  -l, --line-numbers     Print line numbers in output file
  -m, --map=<path>       Read color mapping file (see README)
  -r, --style-ref=<rf>   Set HTML/TeX/LaTeX stylesheet path
  -s, --font-size=<fs>   Set HTML/RTF font size
  -p, --plain            Ignore ANSI formatting information
  -w, --wrap<len>        Wrap long lines
      --no-trailing-nl   Omit trailing newline
      --wrap-no-numbers  Omit line numbers of wrapped lines (assumes -l)
      
ANSI art options:
      --art-cp437        Parse codepage 437 ANSI art (HTML and RTF output)
      --art-bin          Parse BIN/XBIN ANSI art (HTML output, no stdin)
      --art-tundra       Parse Tundra ANSI art (HTML output, no stdin)
      --art-width        Set ANSI art width (default 80)
      --art-height       Set ANSI art height (default 150)
```

![screenshot](https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/master/ansifilter/screenshot.png)
[More screenshots](http://www.andre-simon.de/doku/ansifilter/en/screenshots.php)
