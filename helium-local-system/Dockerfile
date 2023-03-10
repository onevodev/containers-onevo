# build a debian w/ nodered[v3]+influxdb[v2.5]+telegraf setup

#FROM debian:bullseye
FROM debian:latest

MAINTAINER MTF <m.ferrante@onevo.it>

# set up timezone
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NONINTERACTIVE_SEEN=true
RUN ln -sfv /usr/share/zoneinfo/Europe/Rome /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# set up base system
RUN apt update && apt full-upgrade -y && apt install -y \
				git curl wget bash lsb-release gnupg gnupg2 sudo procps systemd

# install programs
COPY scripts /scripts
RUN chmod -R 755 /scripts/* && mv /scripts/setup.sh /scripts/start-daemon.sh /usr/local/bin/
RUN /scripts/install-nodered.sh
RUN /scripts/install-influxdb.sh

# remove sudo for good measure and cleanup
ARG SUDO_FORCE_REMOVE=yes
RUN apt purge -y sudo && apt autoremove -y && rm -rf rm -rf /var/lib/apt/lists/* && rm -rfv /scripts

# open ports
EXPOSE 1880
EXPOSE 8086

# configure daemons [if needed]
#COPY conf/telegraf/telegraf.conf	/etc/telegraf/telegraf.conf
#COPY conf/nodered/flows.json		/home/nodered/.node-red/flows.json

# run daemons
CMD ["exec /usr/local/bin/start-daemon.sh"]
