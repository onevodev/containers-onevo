
This container builds a Debian 11 container with latest Node-RED and InfluxDB installed.

It is specifically tailored to be used along with the [Helium repository ](https://git.onevo.lan/mtf/helium-project) Node-RED flows
and it is set up for specific database tag keys. Do not attempt to use it for anything else if not for having the same type of setup with different configurations.

It has a preconfigured telegraf daemon listening on `localhost:8080/telegraf` which gets data from Node-RED and stores it in the DB
while cleaning up and automatically setting up tag keys.

The container exposes ports _1880_ and _8086_ by default, keep that in mind when running it.

Run `make` to build the image, set it up (interactively) and commit the changes into a pre-configured image.

More documentation will be added as soon as I will have nothing better to do.

#### TO DO: ####

- set option to have a default configuration in order to build the image non-interactively
