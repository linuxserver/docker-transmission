FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="blog.auska.win version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="Auska"

ENV TZ=Asia/Shanghai WEBUI_VERSION=v1.6.0-beta2

RUN \
 echo "**** install packages ****" && \
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
	unzip && \
curl -fSL https://github.com/ronggang/transmission-web-control/archive/${WEBUI_VERSION}.zip -o twc.zip && \
unzip twc.zip -d /tmp && \
mv /usr/share/transmission/web/index.html /usr/share/transmission/web/index.original.html && \
mv /tmp/src/* /usr/share/transmission/web/

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 9091 51413
VOLUME /config /downloads /watch
