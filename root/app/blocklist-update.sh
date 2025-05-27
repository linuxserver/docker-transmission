#!/usr/bin/with-contenv bash
# shellcheck shell=bash

BLOCKLIST_ENABLED=$(jq -r '.["blocklist-enabled"]' /config/settings.json)
PORT=$(jq '.["rpc-port"]' /config/settings.json)

if [[ "$BLOCKLIST_ENABLED" == true ]]; then
    if [[ -n "$USER" ]] && [[ -n "$PASS" ]]; then
        /usr/bin/transmission-remote 127.0.0.1:${PORT:-9091} -n "$USER":"$PASS" --blocklist-update
    else
        /usr/bin/transmission-remote 127.0.0.1:${PORT:-9091} --blocklist-update
    fi
fi
