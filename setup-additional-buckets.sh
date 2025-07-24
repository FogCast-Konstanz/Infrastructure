#!/bin/bash
set -e

influx bucket create \
--name WeatherData \
--org ${DOCKER_INFLUXDB_INIT_ORG} \
--retention 0

influx bucket create \
--name benchmark_score \
--org ${DOCKER_INFLUXDB_INIT_ORG} \
--retention 0