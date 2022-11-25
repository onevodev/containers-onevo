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

# check if config files are present and copy them to the containers
setup_files () {
	for conf in ${CONF_AVAILABLE}; do
		if [ -r ${CONF_DIR}/${conf} ]; then
			case $conf in
			"telegraf.conf")
				CONTAINER=${TELEGRAF_CONTAINER}
				LOCATION="/etc/telegraf/telegraf.conf"
				;;
			*)
				exit 0
				;;
			esac
			[ -n "${CONTAINER}" ] && podman cp ${CONF_DIR}/${conf} ${CONTAINER}:${LOCATION} && podman restart ${CONTAINER}
		fi
	done
}

case $to_setup in

	"nodered")
		setup_nodered
		;;
	"influx")
		setup_influx
		;;
	"configs")
		setup_files
		;;
	"all")
		setup_nodered
		setup_influx
		setup_files
		;;
	*)
		echo "Available options: nodered, influx, configs, all."
		;;
esac
