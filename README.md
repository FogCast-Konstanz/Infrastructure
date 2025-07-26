# Infrastructure for FogCast Project

This repository contains the infrastructure setup for the FogCast project, including configurations for Nginx as a reverse proxy and InfluxDB as the database.

## Components

### Nginx Proxy
- Acts as a reverse proxy for various services.
- Configured to handle SSL certificates and redirect HTTP traffic to HTTPS.
- Routes requests to the FogCast frontend, API, status reporter, and InfluxDB.

### InfluxDB
- Used for storing weather data and forecasts.
- Automatically creates required buckets using the `setup-buckets.sh` script.
- Provides token-based authentication for API access.

## Prerequisites

- Create the `proxy-net` network:
```bash
docker network create proxy-net
```

## Additional Information

- Buckets can be created manually if needed:
```bash
docker exec -it fogcast-influxdb \
influx bucket create \
--name ${BUCKET_NAME} \
--org FogCast \
--retention 0
```

- Tokens for API access can be created using:
```bash
influx auth create \
--org FogCast \
--read-buckets \
--write-buckets \
--description "FogCast API token"
```