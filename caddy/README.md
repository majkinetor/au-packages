# <img src="https://github.com/majkinetor/chocolatey/tree/master/caddy/icon.png" width="48" height="48"/> [![](https://img.shields.io/chocolatey/v/caddy.svg?color=red&label=caddy)](https://chocolatey.org/packages/caddy)

Caddy is a powerful, extensible platform to serve your sites, services, and apps, written in Go.

## Features

- **Easy configuration** with the [Caddyfile](https://caddyserver.com/docs/caddyfile)
- **Powerful configuration** with its [native JSON config](https://caddyserver.com/docs/json/)
- **Dynamic configuration** with the [JSON API](https://caddyserver.com/docs/api)
- [**Config adapters**](https://caddyserver.com/docs/config-adapters) if you don't like JSON
- **Automatic HTTPS** by default
	- [Let's Encrypt](https://letsencrypt.org) for public sites
	- Fully-managed local CA for internal names & IPs
	- Can coordinate with other Caddy instances in a cluster
- **Stays up when other servers go down** due to TLS/OCSP/certificate-related issues
- **HTTP/1.1, HTTP/2, and experimental HTTP/3** support
- **Highly extensible** [modular architecture](https://caddyserver.com/docs/architecture) lets Caddy do anything without bloat
- **Runs anywhere** with **no external dependencies** (not even libc)
- Written in Go, a language with higher **memory safety guarantees** than other servers

## Notes

- This packages installs caddy with standard [modules](https://caddyserver.com/docs/modules) only. If you need to install caddy with additional packages you need to build it with those packages included. You can use official caddy [download](https://caddyserver.com/download) page to select and build custom caddy version. Its not possible at this moment to do this via package unless it reimplements custom build.