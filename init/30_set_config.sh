#!/bin/bash

mkdir -p /downloads/{complete,incomplete} /watch

[[ ! -f /config/settings.json ]] && cp /defaults/settings.json /config/settings.json

chown abc:abc /watch /config/settings.json /downloads /downloads/incomplete /downloads/complete
