#!/usr/bin/with-contenv bash

BLOCKLIST_ENABLED=`jq -r '.["blocklist-enabled"]' /config/settings.json`
BLOCKLIST_URL=`jq -r '.["blocklist-url"]' /config/settings.json | sed 's/\&amp;/\&/g'`
SCRIPT_DEBUG=false

# Exit if Block list is not enabled
[ $BLOCKLIST_ENABLED == true ] || exit 0

# Check if custom script exists in config folder
if [ -e /config/blocklist-update.sh ]; then
	[ $SCRIPT_DEBUG == true ] && echo "Custom script found Running [/config/update-blocklist.sh]"
	/config/blocklist-update.sh
	ret=$((ret + $?))
	[ $SCRIPT_DEBUG == true ] && echo "Custom script at [/config/blocklist-update.sh] exited with [$ret]"
else
	[ $SCRIPT_DEBUG == true ] && echo "Running [/app/update-blocklist.sh]"
	mkdir -p /tmp/blocklists
	rm -rf /tmp/blocklists/*
	cd /tmp/blocklists
	wget -q -O blocklist.gz "$BLOCKLIST_URL"
	ret=$((ret + $?))
	[ $SCRIPT_DEBUG == true ] && echo "blocklist at [$BLOCKLIST_URL] downloaded exited with [$ret]"
	if [ $ret == 0 ]; then
		gunzip *.gz
		ret=$((ret + $?))
		[ $SCRIPT_DEBUG == true ] && echo "Gunzip extracted [$(ls)] and exited with [$ret]"
		if [ $ret == 0 ]; then
			chmod go+r *
			rm -rf /config/blocklists/*
			cp /tmp/blocklists/* /config/blocklists
			[ $SCRIPT_DEBUG == true ] && echo "[$(ls /tmp/blocklists/*)] copied to [/config/blocklists]"
		fi
	fi
fi


[ $SCRIPT_DEBUG == true ] && echo "Transmission will restart if return values [$ret] is equal to \"0\""
# Restart Transmission after blocklist update
[ $ret == 0 ] && s6-svc -t /var/run/s6/services/transmission
