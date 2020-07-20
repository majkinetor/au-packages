# [![](https://img.shields.io/chocolatey/v/tcp-copytree.svg?color=red&label=tcp-copytree)](https://chocolatey.org/packages/tcp-copytree)

Total Commander packer plugin for copying files with folder structure.

Plugin allows you to keep directory structure when you copy/move files from branch view (Ctrl+[Shift+]B by default, or "Branch View" command) or search results panel ('Feed to listbox' button in search results dialog). TC copies files in theese modes w/o keeping directory structure, into single directory (TC 8.50+ allow keeping directory structure relative to current directory in case of branch view).

See [TCP Scripts](https://chocolatey.org/packages/tcps) for package parameters and other notes.

## Features

- copies/moves folder trees from branch view/search result
- 'choose number of levels to copy' dialog that allows observing relative paths for all cases
- allows setting up include/exclude masks for files to be processed
- allows displaying choose dialog once or if Win key is down or every time
- multi-threading support (background operations in TC 7.55 and later)
- allows copying directory timestamps
- reports if some files weren't processed
- full Unicode support
