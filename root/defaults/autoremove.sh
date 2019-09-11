#!/bin/bash

#Path to the script
SCRIPT=/defaults/transmission_remove_finished

#Verify if autoremove is activated
if [[ $AUTOREMOVE = yes ]]; then
	#Verify if the authentication is activated
	if [[ $AUTHENABLE = yes ]] || [[ ! -z USER ]] && [[ ! -z PASS ]]; then
		curl -L "https://gist.githubusercontent.com/tzinm/003a062ee985eb1fdd22bab6113486d6/raw/5e3ed23dbfec61aa98e68b1464148c995f61034c/docker_transmission_remove_finished.sh" > $SCRIPT
		chmod 700 $SCRIPT
	elif [ -z $AUTHENABLE ] || [ $AUTHENABLE = no ]; then
		curl -L "https://gist.githubusercontent.com/tzinm/003a062ee985eb1fdd22bab6113486d6/raw/5e3ed23dbfec61aa98e68b1464148c995f61034c/docker_transmission_remove_finished.sh" > $SCRIPT
		chmod 700 $SCRIPT
		sed -i -e 's/^SERVER/#SERVER/g' -e 's/$SERVER//g' $SCRIPT
	fi
	#Stablish when the script runs
	if [[ $CRONDATE = daily ]]; then
		mv $SCRIPT /etc/periodic/daily/.
	elif [[ $CRONDATE = weekly ]]; then
		mv $SCRIPT /etc/periodic/weekly/.
	elif [[ $CRONDATE = monthly ]]; then
		mv $SCRIPT /etc/periodic/monthly/.
	else
		CRONDATE=monthly
		mv $SCRIPT /etc/periodic/monthly.
	fi
fi

#Delete the line in crontab corresponding to this script
sed -i '/@reboot/d' /etc/crontabs/root 2>/dev/null

#Autodeleting the script
rm -rf $0
