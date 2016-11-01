#!/usr/bin/with-contenv bash

BLOCKLIST_URL=`jq -r '.["blocklist-url"]' /config/settings.json`

rm /config/blocklists/*
cd /config/blocklists
wget -q $BLOCKLIST_URL -O blocklist.gz
gunzip *.gz
chmod go+r *
s6-svc -h /var/run/s6/services/transmission
