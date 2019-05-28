# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/gitlab-runner/icon.png" width="48" height="48"/>  [![](https://img.shields.io/chocolatey/v/gitlab-runner.svg?color=red&label=gitlab-runner)](https://chocolatey.org/packages/gitlab-runner)

GitLab Runner is the open source project that is used to run your jobs and send the results back to GitLab. It is used in conjunction with GitLab CI, the open-source continuous integration service included with GitLab that coordinates the jobs.

## Features

- Allows to run:
  - multiple jobs concurrently
  - use multiple tokens with multiple server (even per-project)
  - limit number of concurrent jobs per-token
- Jobs can be run:
  - locally
  - using Docker containers
  - using Docker containers and executing job over SSH
  - using Docker containers with autoscaling on different clouds and virtualization hypervisors 
  - connecting to remote SSH server
- Is written in Go and distributed as single binary without any other requirements
- Supports Bash, Windows Batch and Windows PowerShell
- Works on GNU/Linux, OS X and Windows (pretty much anywhere you can run Docker)
- Allows to customize the job running environment
- Automatic configuration reload without restart
- Easy to use setup with support for Docker, Docker-SSH, Parallels or SSH running environments
- Enables caching of Docker containers
- Easy installation as a service for GNU/Linux, OSX and Windows
- Embedded Prometheus metrics HTTP server

## Package parameters

- `/InstallDir` - Installation directory. If the Gitlab Runner is already installed, its current directory will be used. To install to a new directory, uninstall it first.
- `/Service` - Install as a service. If value is not specified system account will be used. If value is specified it is in the form of `Username:Password`. The installer will create that user if it doesn't exist, add it to local administrators group, enable _ServiceLogonRight_ and disable password expiration. Example: `/Service:gitlab-runner:P@ssw0rd`. Can't be used with `Autologon` parameter
- `/Autologon` - Use autologon feature of Windows. Can't be used with `Service` parameter. Username and password must be provided. Example: `/Autologon:gitlab-runner:P@ssw0rd`.

## Notes

- The script `register_example.ps1` is provided along the executable which can be used to quickly register runner non-interactively. If you want to use it, rename it to `register.ps1` and set desired environment variables.
- Autologon vs Service: Services do not have access to all Windows features and some scripts, particularly those that depend on GUI, are not usable.
