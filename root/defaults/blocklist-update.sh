#!/usr/bin/with-contenv bash

BLOCKLIST_ENABLED=`jq -r '.["blocklist-enabled"]' settings.json`
BLOCKLIST_URL=`jq -r '.["blocklist-url"]' settings.json`

if [ $BLOCKLIST_ENABLED == true ]; then
	mkdir -p /tmp/blocklists
	rm -rf /tmp/blocklists/*
	cd /tmp/blocklists
	wget -q $BLOCKLIST_URL
	if [ $? == 0 ]; then
		gunzip *.gz
		if [ $? == 0 ]; then
			chmod go+r *
			rm -rf /config/blocklists/*
			cp /tmp/blocklists/* /config/blocklists
			s6-svc -h /var/run/s6/services/transmission
		fi
	fi
fi
