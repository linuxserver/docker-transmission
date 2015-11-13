FROM linuxserver/baseimage

MAINTAINER Sparklyballs <sparklyballs@linuxserver.io>

ENV APTLIST="transmission-daemon"

# add repository
RUN add-apt-repository ppa:transmissionbt/ppa && \

# install packages
apt-get update -q && \
apt-get install $APTLIST -qy && \

# cleanup
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

#Adding Custom files
#ADD init/ /etc/my_init.d/
#ADD services/ /etc/service/
#ADD cron/ /etc/cron.d/
#ADD defaults/ /defaults/
RUN chmod -v +x /etc/service/*/run && chmod -v +x /etc/my_init.d/*.sh && \
   
# give abc user home folder /config
usermod -d /config abc 

# Volumes and Ports
VOLUME /config /downloads 
EXPOSE 9091 51413
