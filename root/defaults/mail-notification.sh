#!/bin/sh

# set here the recipient for mail notifications
MAIL_TO=
# set the FROM field of mail
MAIL_FROM=


if [ -z "${MAIL_SUBJECT}" ]; then
  MAIL_SUBJECT='[Transmission] Torrent Done!'
fi

(
  echo "To: ${MAIL_TO}
From: ${MAIL_FROM}
Subject: ${MAIL_SUBJECT}
Hi,

This is an automated message reporting that the following torrent has finished to be downloaded.

Torrent informations:
  Torrent : ${TR_TORRENT_NAME}
  Time    : ${TR_TIME_LOCALTIME}
  Location: ${TR_TORRENT_DIR}
  Hash    : ${TR_TORRENT_HASH}
  ID      : ${TR_TORRENT_ID}
  Version : ${TR_APP_VERSION}

Regards"
) | sendmail ${MAIL_TO}
