FROM ghcr.io/linuxserver/baseimage-alpine:3.13

ARG BUILD_DATE
ARG VERSION
ARG TRANSMISSION_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	ca-certificates \
	curl \
	findutils \
	jq \
	openssl \
	p7zip \
	python3 \
	rsync \
	tar \
	unrar \
	unzip \
	transmission-cli \
	transmission-daemon \
	nodejs \
	npm && \
 echo "**** install transmission ****" && \
 if [ -z ${TRANSMISSION_VERSION+x} ]; then \
	TRANSMISSION_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/v3.13/community/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
	&& awk '/^P:transmission-daemon$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
 fi && \
 apk add --no-cache \
	transmission-cli==${TRANSMISSION_VERSION} \
	transmission-daemon==${TRANSMISSION_VERSION} && \
 echo "**** install third party themes ****" && \
 curl -o \
	/tmp/combustion.tar.gz -L \
	"https://github.com/Secretmapper/combustion/archive/release.tar.gz" && \
 tar xf \
	/tmp/combustion.tar.gz -C \
	/ --strip-components=1 && \
 mkdir -p /tmp/twctemp && \
 TWCVERSION=$(curl -sX GET "https://api.github.com/repos/ronggang/transmission-web-control/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
	/tmp/twc.tar.gz -L \
	"https://github.com/ronggang/transmission-web-control/archive/${TWCVERSION}.tar.gz" && \
 tar xf \
	/tmp/twc.tar.gz -C \
	/tmp/twctemp --strip-components=1 && \
 mv /tmp/twctemp/src /transmission-web-control && \
 mkdir -p /kettu && \
 curl -o \
	/tmp/kettu.tar.gz -L \
	"https://github.com/endor/kettu/archive/master.tar.gz" && \
 tar xf \
	/tmp/kettu.tar.gz -C \
	/kettu --strip-components=1 && \
 mkdir -p /flood-for-transmission && \
 mkdir -p /tmp/flood-for-transmission && \
 curl -o \
	/tmp/flood-for-transmission.tar.gz -L \
	"https://github.com/johman10/flood-for-transmission/archive/master.tar.gz" && \
 tar xf \
	/tmp/flood-for-transmission.tar.gz -C \
	/tmp/flood-for-transmission --strip-components=1 && \
 cd /tmp/flood-for-transmission && \
 npm ci && \
 npm run build && \
 cd / && \
 mv /tmp/flood-for-transmission/public/** /flood-for-transmission && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/* && \
 apk del nodejs npm


# copy local files
COPY root/ /

# ports and volumes
EXPOSE 9091 51413
VOLUME /config /downloads /watch
