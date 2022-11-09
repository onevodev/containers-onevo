#!/bin/bash

# start InfluxDB
echo "Starting InfluxDB..."
/usr/lib/influxdb/scripts/influxd-systemd-start.sh >> /var/log/influxdb.log 2>&1
echo "Done."

# start Node-RED
echo "Starting Node-RED..."
su -c "node-red" nodered >> /var/log/nodered.log 2>&1 &
echo "Done."

# start Telegraf
echo "Starting Telegraf..."
service telegraf start
echo "Done."

# view logs
echo "Reading logs, Ctrl+C to stop and exit."
sleep 2
tail -f /var/log/nodered.log -f /var/log/influxdb.log

# wait for any process to exit
wait -n

# exit with status of process that exited first
exit $?
