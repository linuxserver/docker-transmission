FROM lsiobase/alpine
MAINTAINER sparklyballs

# install packages
RUN \
 apk add --no-cache \
	transmission-daemon

# add local files
COPY root/ /

# Volumes and Ports
VOLUME /config /downloads /watch
EXPOSE 9091 51413
