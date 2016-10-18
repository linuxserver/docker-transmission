#!/usr/bin/with-contenv bash

RESULT=`jq '.["blocklist-enabled"]' settings.json`
REQUIRE_AUTH=`jq '.["rpc-authentication-required"]' settings.json`

if [ $RESULT == true ]; then
	if [ $REQUIRE_AUTH == true ]; then
		transmission-remote -n $UIUSER:$UIPASS --blocklist-update
	else
		transmission-remote --blocklist-update
	fi
fi