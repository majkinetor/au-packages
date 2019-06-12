# [![](https://img.shields.io/chocolatey/v/less.svg?color=red&label=less)](https://chocolatey.org/packages/less)

Less is a CLI pager, a program that displays text files. Other pagers commonly in use are `more` and `pg`. Less is similar to `more`, but allows backward movement in the file as well as forward movement. Also, less does not have to read the entire input file before starting, so with large input files it starts up faster than text editors like vi.

## Notes
  
- If you are using [PSCX](https://chocolatey.org/packages/pscx), you must override its internally distributed less version using the following in your `$PROFILE`: `($Pscx:Preferences).PageHelpUsingLess = $false`