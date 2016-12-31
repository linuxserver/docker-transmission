#!/usr/bin/env python

# -*- coding: utf8 -*-

# System imports
from email.mime.text import MIMEText
from os import environ
import smtplib
import sys

# if SMTP server is not defined, the script will not run
if 'SMTP_SERVER' in environ:
  smtp_server = environ['SMTP_SERVER']
else:
  sys.exit(0)

# SMTP port
if 'SMTP_PORT' in environ:
  smtp_port = environ['SMTP_PORT']
else:
  smtp_port = 25

# SMTP sender adress
if 'SMTP_FROM' in environ:
  smtp_from = environ['SMTP_FROM']
else:
  sys.exit(1)

# SMTP recipient address
if 'SMTP_TO' in environ:
  smtp_to = environ['SMTP_TO']
else:
  sys.exit(1)

# Configure SMTP AUTH if needed
if 'SMTP_USERNAME' in environ and 'SMTP_PASSWORD' in environ:
  smtp_auth = True
  smtp_username = environ['SMTP_USERNAME']
  smtp_password = environ['SMTP_PASSWORD']
else:
  smtp_auth = False

if 'SMTP_STARTTLS' in environ:
  smtp_starttls = environ['SMTP_STARTTLS'] == 'yes'
else:
  smtp_starttls = False

if 'SMTP_SSL' in environ:
  smtp_ssl = environ['SMTP_SSL'] == 'yes'
else:
  smtp_ssl = False

# The mail subject
if 'MAIL_SUBJECT' in environ:
  mail_subject = environ['MAIL_SUBJECT']
else:
  mail_subject = '[Transmission] Torrent Done!'

# The mail body template
mail_body = """Hi,

This is an automated message reporting that the following torrent has finished to be downloaded.

Torrent informations:
  Torrent : {TR_TORRENT_NAME}
  Time    : {TR_TIME_LOCALTIME}
  Location: {TR_TORRENT_DIR}
  Hash    : {TR_TORRENT_HASH}
  ID      : {TR_TORRENT_ID}
  Version : {TR_APP_VERSION}

Regards,
""".format(**environ)

# Configure SSL
if smtp_ssl == True:
  m = smtplib.SMTP_SSL(host=smtp_server,
                       port=smtp_port,
                       timeout=10)
else:
  m = smtplib.SMTP(host=smtp_server,
                   port=smtp_port,
                   timeout=10)

# Use starttls
if smtp_starttls == True:
  m.starttls()
if smtp_auth == True:
  m.login(smtp_username, smtp_password)

# Building mail
msg = MIMEText(mail_body)
msg['Subject'] = mail_subject
msg['From'] = smtp_from
msg['To'] = smtp_to
m.sendmail(smtp_from, smtp_to.split(';'), msg.as_string())
m.quit()
