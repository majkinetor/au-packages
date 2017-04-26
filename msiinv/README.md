# msiinv

**Install**: `iwr https://goo.gl/0aP4PK | iex; cinst-majkinetor msiinv`

Provides information about the state of all Windows Installer products, features and components.


## Usage

    PS> msiinv.exe [option [option]]
        -p [product]    Product list
        -f      Feature state by product. (includes -p)
        -q      Component count by product (includes -p)
        -#      Component count and features states by product (-p -f -q)

        -x      Orphaned components.
        -m      Shared components.
        -c      Evaluate components (-x -m).

        -l      List of log files.

        -s      Reduced output.(-p -#)
        -n      Normal output. (default)
        -v      Verbose output. (default + feature and component lists)

## Notes

- This tool is not supported or recommended by Microsoft
