#!/bin/sh
# script to check for completed torrents and stop and remove them

TORRENTLIST=`transmission-remote --list | sed -e '1d;$d;s/^ *//' | cut -f1 -d' '`

for TORRENTID in $TORRENTLIST
do
  TORRENTID=`echo "$TORRENTID" | sed 's:*::'`

  INFO=`transmission-remote --torrent $TORRENTID --info`

  NAME=`echo "$INFO" | grep "Name: *"`
  DL_COMPLETED=`echo "$INFO" | grep "Percent Done: 100%"`
  STATE_STOPPED=`echo "$INFO" | grep "State: Stopped\|Finished\|Idle"`

  if [ "$DL_COMPLETED" != "" ] && [ "$STATE_STOPPED" != "" ]; then
    echo "Torrent $TORRENTID is in $STATE_STOPPED"
    echo "$NAME"
    echo "Removing torrent from list"
    transmission-remote --torrent $TORRENTID --stop
  fi
done