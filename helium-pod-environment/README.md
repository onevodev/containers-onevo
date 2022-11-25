# HELIUM ENVIRONMENT FOR LOCAL DEPLOYMENT

**This environment consists of a Node-RED, InfluxDB (*v2*) and Telegraf environment to be set up for local LoRaWAN gateways data collection and visualizations.**  
The deployment is raw, and the subsequent configuration is supposed to be stored inside volumes automatically created and attached.  
The environment is supposed to work with [this repo](https://github.com/onevodev/somerepo), which contains Node-RED flows and custom configurations
for easy deployment. Set up the environment, clone the configs and just by specifying the identificative parameters of each pod you should be good to go.

## TODO

- in `backup-volumes.sh` set up deletion for only certain volumes, although might be redundant with podman CLI itself.

## SETUP:

The system is made to be replicable just by copying the repository to another directory and *only* editing the `.env` file, so that
the containers are clones of each other and only differ by the name they're called. It should become easy then to deploy and configure multiple 
instances. **Take care** of the names of the volumes as well, as there should be one for each container, in order to keep configs and data.

## HOWTO:

The scripts are set up in the following way, in the order they should be run:

- `setup-environment.sh` : set up a pod with options specified in `POD_OPTS`, volumes specified in `VOLUMES` and containers necessary. [*Node-RED, InfluxDB and Telegraf*]

- `configure-services.sh` : since the system comes totally unconfigured, this script executes setup scripts in Node-RED and InfluxDB containers.  
Also, if present in `CONF_DIR`, it will copy the `telegraf.conf` configuration to the telegraf container and restart it.

- `start.sh` , `stop.sh` : these are easy, idiot-proof way to start and stop the pod, with `stop.sh` supporting `--rm` option to delete the pod (*but not the volumes*).

- `backup-volumes.sh` : backs up `VOLUMES` tarballs inside `BAK_DIR`, by making a subfolder for each volume and appending current date to each backup. *Note that this will make multiple backups a day overwrite each other, as date format is* `date -I`.

- `delete-volumes.sh` : completely deletes `VOLUMES`, may be useful in case of wanting to import an old volume backup.
