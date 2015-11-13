#!/bin/bash

mkdir -p /downloads/incomplete /downloads/complete

[[ ! -f /config/settings.json ]] && cp /defaults/settings.json /config/settings.json

mkdir -p /config/watch

chown abc:abc /config/watch /config/settings.json /downloads /downloads/incomplete /downloads/complete
