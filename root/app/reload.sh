#!/usr/bin/with-contenv bash
# shellcheck shell=bash

pid=$(pidof transmission-daemon)

/bin/kill -s HUP ${pid}

echo "Transmission reloaded"
