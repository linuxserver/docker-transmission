#!/usr/bin/with-contenv bash

BLOCKLIST_ENABLED=`jq -r '.["blocklist-enabled"]' settings.json`
BLOCKLIST_URL=`jq -r '.["blocklist-url"]' settings.json`

if [ $BLOCKLIST_URL == true ]; then
	mkdir -p /tmp/blocklist
	cd /tmp/blocklist
	wget -q $BLOCKLIST_URL
	if [ $? == 0 ]; then
		gunzip *.gz
		if [ $? == 0 ]; then
			chmod go+r *
			rm /config/blocklists/*
			cp /tmp/blocklists/* /config/blocklists
			s6-svc -h /var/run/s6/services/transmission
		fi
	fi
fi
