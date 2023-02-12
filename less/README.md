# [![](https://img.shields.io/chocolatey/v/less.svg?color=red&label=less)](https://chocolatey.org/packages/less)

Less is a CLI pager, a program that displays text files. Other pagers commonly in use are `more` and `pg`. Less is similar to `more`, but allows backward movement in the file as well as forward movement. Also, less does not have to read the entire input file before starting, so with large input files it starts up faster than text editors like vi.

## Features

- Backward and forward movement
- Searching, filtering and highlighting, multifile search, regular expressions
- Multiple files, remembering position in each file
- Font styles: bold and underline
- Advanced features: key bindings, tab stops, prompt customization, line numbers, tag, options in environment variable, file preprocessor
- Cross platform

## Package Parameters

- `/DefaultPager` - Set `$Env:PAGER` environment variable to `less`.

## Notes

- If you are using [PSCX](https://chocolatey.org/packages/pscx), you must override its internally distributed less version using the following in your `$PROFILE`: `($Pscx:Preferences).PageHelpUsingLess = $false`
- This package uses x64 bit version of John Taylor's automatic [build](https://github.com/jftuga/less-Windows)