# Nginx proxy and InfluxDB database for the FogCast project

## Prerequisites

Create the proxy-net network
```bash
docker network create proxy-net
```

## Create Additional Buckets

There is a script that creates all buckets needed for the FogCast project.
It will be run automatically when the InfluxDB container is created the first time.

If the container is already created, you can create the buckets manually.

```bash
docker exec -it fogcast-influxdb \
influx bucket create \
--name ${BUCKET_NAME} \
--org FogCast \
--retention 0
```

## Create InfluxDB tokens

Create a token for the FogCast API to read and write data from the database.

```bash
influx auth create \
--read-bucket ${WEATHER_FORECAST_BUCKET_ID} \
--write-bucket ${WEATHER_FORECAST_BUCKET_ID} \
--read-bucket ${WEATHER_DATA_BUCKET_ID} \
--write-bucket ${WEATHER_DATA_BUCKET_ID} \
--description "FogCast API token"
```