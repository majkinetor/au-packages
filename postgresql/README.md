# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/postgresql/icon.png" width="48" height="48"/> [![](https://img.shields.io/chocolatey/v/postgresql.svg?color=red&label=postgresql)](https://chocolatey.org/packages/postgresql)

PostgreSQL is an object-relational database management system (ORDBMS) based on POSTGRE, developed at the University of California at Berkeley Computer Science Department. POSTGRES pioneered many concepts that only became available in some commercial database systems much later.

PostgreSQL can be used, modified, and distributed by anyone free of charge for any purpose, be it private, commercial, or academic.

## Features

- [Feature Matrix](https://www.postgresql.org/about/featurematrix)

## Package parameters

- `/Password` - Password to be assigned to the `postgres` user. If ommited, it will be generated and shown in install output.

## Notes

- This package will install PostgreSQL to `$Env:ProgramFiles\PostgreSQL\[MajorVersion]`
- [Silent install options](https://www.enterprisedb.com/edb-docs/d/postgresql/installation-getting-started/installation-guide-installers/10/PostgreSQL_Installation_Guide.1.16.html)
- If you have problems during installation see [troubleshooting page](https://wiki.postgresql.org/wiki/Troubleshooting_Installation)
