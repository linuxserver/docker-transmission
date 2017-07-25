FROM lsiobase/alpine:3.6
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install packages
RUN \
 apk add --no-cache \
	curl \
	jq \
	openssl \
	p7zip \
	rsync \
	tar \
	transmission-cli \
	transmission-daemon \
	unrar \
	unzip

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 9091 51413
VOLUME /config /downloads /watch
