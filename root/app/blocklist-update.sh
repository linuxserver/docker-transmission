#!/usr/bin/with-contenv bash

BLOCKLIST_ENABLED=$(jq -r '.["blocklist-enabled"]' /config/settings.json)

if [ "$BLOCKLIST_ENABLED" == true ]; then
  if [ -n "$USER" ] && [ -n "$PASS" ]; then
    /usr/bin/transmission-remote -n "$USER":"$PASS" --blocklist-update
  else
    /usr/bin/transmission-remote --blocklist-update
  fi
fi
