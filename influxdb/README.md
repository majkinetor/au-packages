# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/influxdb/icon.png" width="48" height="48"/> [![](https://img.shields.io/chocolatey/v/influxdb.svg?color=red&label=influxdb)](https://chocolatey.org/packages/influxdb)

InfluxDB is a time series database designed to handle high write and query loads. It is an integral component of the TICK stack. InfluxDB is meant to be used as a backing store for any use case involving large amounts of timestamped data, including DevOps monitoring, application metrics, IoT sensor data, and real-time analytics.

## Features

- Custom high performance datastore written specifically for time series data. The TSM engine allows for high ingest speed and data compression
- Written entirely in Go. It compiles into a single binary with no external dependencies.
- Simple, high performing write and query HTTP APIs.
- Plugins support for other data ingestion protocols such as Graphite, collectd, and OpenTSDB.
- Expressive SQL-like query language tailored to easily query aggregated data.
- Tags allow series to be indexed for fast and efficient queries.
- Retention policies efficiently auto-expire stale data.
- Continuous queries automatically compute aggregate data to make frequent queries more efficient.

## Package parameters

-  `/InstallRoot` - Installation directory root, by default `c:\influxdata`

## Notes

- The open source edition of InfluxDB runs on a single node. If you require high availability to eliminate a single point of failure, consider the [InfluxDB Enterprise Edition](https://www.influxdata.com/products/influxdb-enterprise).
- InfluxDB v1.x package: [influxdb1](https://chocolatey.org/packages/influxdb1)
- InfluxDB v2.x package: [influxdb2](https://chocolatey.org/packages/influxdb2) [future]

