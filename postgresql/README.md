# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/postgresql/icon.png" width="48" height="48"/> [![](https://img.shields.io/chocolatey/v/postgresql.svg?color=red&label=postgresql)](https://chocolatey.org/packages/postgresql) [![](https://img.shields.io/chocolatey/v/postgresql12.svg?color=red&label=postgresql12)](https://chocolatey.org/packages/postgresql12) [![](https://img.shields.io/chocolatey/v/postgresql11.svg?color=red&label=postgresql11)](https://chocolatey.org/packages/postgresql11) [![](https://img.shields.io/chocolatey/v/postgresql10.svg?color=red&label=postgresql10)](https://chocolatey.org/packages/postgresql10) [![](https://img.shields.io/chocolatey/v/postgresql9.svg?color=red&label=postgresql9)](https://chocolatey.org/packages/postgresql9)

PostgreSQL is an object-relational database management system (ORDBMS) based on POSTGRE, developed at the University of California at Berkeley Computer Science Department. POSTGRES pioneered many concepts that only became available in some commercial database systems much later.

PostgreSQL can be used, modified, and distributed by anyone free of charge for any purpose, be it private, commercial, or academic.

## Features

- [Feature Matrix](https://www.postgresql.org/about/featurematrix)

## Package parameters

- `/Password` - Password to be assigned to the `postgres` user. If ommited, it will be generated and shown in install output.
- `/NoPath` - Do not add postgresql bin directory to the PATH.

## Notes

- This package will install PostgreSQL to `$Env:ProgramFiles\PostgreSQL\[MajorVersion]`.
- [Silent install options](https://www.enterprisedb.com/edb-docs/d/postgresql/installation-getting-started/installation-guide-installers/10/PostgreSQL_Installation_Guide.1.16.html).
- If you have problems during installation see [troubleshooting page](https://wiki.postgresql.org/wiki/Troubleshooting_Installation).
- Each major version has its own package: [postgresql12](https://chocolatey.org/packages/postgresql12), [postgresql11](https://chocolatey.org/packages/postgresql11), [postgresql10](https://chocolatey.org/packages/postgresql10), [postgresql9](https://chocolatey.org/packages/postgresql9). Virtual package [postgresql](https://chocolatey.org/packages/postgresql) also contains all versions that depend on adequate major version.
- To propagate package parameters to dependencies use `--paramsglobal` choco install parameter. For example, to provide password using virtual package, the following two examples provide the same result:
    ```
    cinst postgresql --params '/Password:test' --paramsglobal
    cinst postgresql12 --params '/Password:test'
    ```
