#!/bin/bash

set -e
# env vars
source .env

to_setup="${1:-both}"

# check if containers are running and configure the services
setup_nodered () {
	[ -z "$(podman ps | grep -w ${NRED_CONTAINER} | grep -v 'CONTAINER')" ] && (echo "Node-RED container does not appear to be running..." ; exit 1)
	echo "Setting up Node-RED..."
	podman exec -it ${NRED_CONTAINER} node-red admin init
}
setup_influx () {
	[ -z "$(podman ps | grep -w ${INFLUX_CONTAINER} | grep -v 'CONTAINER')" ] && (echo "InfluxDB container does not appear to be running..." ; exit 1)
	echo "Setting up InfluxDB..."
	podman exec -it ${INFLUX_CONTAINER} influx setup
}

case $to_setup in

	"nodered")
		setup_nodered
		;;
	"influx")
		setup_influx
		;;
	"both")
		setup_nodered
		setup_influx
		;;
	*)
		echo "Available options: nodered, telegraf, both."
		;;
esac
