# Infrastructure for FogCast Project

This repository contains the infrastructure setup for the FogCast project, including configurations for Nginx as a reverse proxy and InfluxDB as the database.

## Components

### Nginx Proxy
- Acts as a reverse proxy for various services.
- Configured to handle SSL certificates and redirect HTTP traffic to HTTPS.
- Routes requests to the FogCast frontend, API, status reporter, and InfluxDB.

### InfluxDB
- Used for storing weather data and forecasts.
- Automatically creates required buckets using the `setup-buckets.sh` script, but only on the first startup.
- Provides token-based authentication for API access.

## Prerequisites

- Create the `proxy-net` network:
```bash
docker network create proxy-net
```

## Creating buckets and tokens

The preferred way to create buckets and tokens in the InfluxDB is to use the Web-UI. Because the InfluxDB is behind a NGINX reverse proxy, the Web-UI isn't accessible. This is because of a bug / missing feature in the InfluxDB: https://github.com/influxdata/influxdb/issues/15721 

Thats why when you want to create a bucket or a token you have to use the CLI. Accessing the CLI of the InfluxDB when it's running in a container can be done with the command `docker exec -it fogcast-influxdb /bin/sh`.

### Creating new buckets

```bash
influx bucket create \
--name ${BUCKET_NAME} \
--org FogCast \
--retention 0
```
There is also a good [documentation](https://docs.influxdata.com/influxdb/v2/admin/buckets/) on how to manage buckets via the CLI.

### Creating new tokens

```bash
influx auth create \
--org FogCast \
--read-buckets \
--write-buckets \
--description "FogCast API token"
```

Just like for the buckets, there is also an official [documentation](https://docs.influxdata.com/influxdb/v2/admin/tokens/) on how to manage tokens.



