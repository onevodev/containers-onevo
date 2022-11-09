# build a debian w/ nodered[v3]+influxdb[v2.5]


FROM debian:bullseye

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
RUN /scripts/install-nodered.sh
RUN /scripts/install-influxdb.sh

# remove sudo for good measure
RUN apt purge -y sudo && apt autoremove -y
# cleanup
rm -rf /var/lib/apt/lists/*

# open ports
EXPOSE 1880
EXPOSE 8086

# configure daemons
COPY conf/telegraf/telegraf.conf	/etc/telegraf/telegraf.conf

# run daemons
CMD [ "/scripts/start-daemon.sh" ]
