FROM lsiobase/alpine
MAINTAINER sparklyballs

# install packages
RUN \
 apk add --no-cache \
	transmission-daemon

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 9091 51413
VOLUME /config /downloads /watch
