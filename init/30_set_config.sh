#!/bin/bash

mkdir -p /downloads/{complete,incomplete} /config/watch

[[ ! -f /config/settings.json ]] && cp /defaults/settings.json /config/settings.json

chown abc:abc /config/watch /config/settings.json /downloads /downloads/incomplete /downloads/complete
