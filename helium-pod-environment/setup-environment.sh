#!/bin/sh

set -e
# env vars
source ./.env

# create pod if it doesn't exist
[ -z "$(podman pod ps | grep -w ${POD_NAME} | grep -v CONTAINER)" ] || (echo "A pod named '${POD_NAME}' already exists!" ; exit 1)
echo "Creating pod..."
podman pod create ${POD_OPTS} ${POD_NAME}

# create volumes [if they don't exist]
for volume in ${VOLUMES}; do
	[ -z "$(podman volume ls | grep -w ${volume})" ] && podman volume create $volume
done

# start nodered
echo "Starting up Node-RED..."
podman run -d --pod ${POD_NAME} -v nodered:${NRED_DATA} --name ${NRED_CONTAINER} docker.io/nodered/node-red

# start influxdb
echo "Starting up InfluxDB..."
podman run -d --pod ${POD_NAME} -v influx:${INFLUX_DATA} --name ${INFLUX_CONTAINER} docker.io/library/influxdb

# start telegraf
echo "Starting up Telegraf..."
#podman run -d --pod ${POD_NAME} -v telegraf:${TELEGRAF_DATA} --name ${TELEGRAF_CONTAINER} docker.io/library/telegraf
# temporary fix as per https://github.com/influxdata/influxdata-docker/issues/646
podman run -d --pod ${POD_NAME} -v telegraf:${TELEGRAF_DATA} --name ${TELEGRAF_CONTAINER} --entrypoint=telegraf docker.io/library/telegraf

echo "Done"

# begin reading logs
podman pod logs -f ${POD_NAME}
