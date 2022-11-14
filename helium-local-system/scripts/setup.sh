#!/bin/sh

# this is the interactive part of the configuration,
# it needs to be run once the image is built to set up
# password and configs

# set up nodered
echo "Setting up Node-RED..."
chown -R nodered:nodered /home/nodered
su -c "cd && node-red admin init" nodered
chown root:root /home/nodered/.node-red/settings.js
echo "Done."

# set up influx
echo "Setting up InfluxDB..."
/usr/lib/influxdb/scripts/influxd-systemd-start.sh > /dev/null 2>&1
influx setup
echo "Done."

exit 0
