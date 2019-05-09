#!/bin/bash

#If I am logged in, do nothing
if who | grep -wq kevin 
then
	/usr/sbin/ssmtp shocktohp@cock.li < /home/kevin/testmail
	exit
fi

# If I am not logged in, check if there are any downloads in progress
# If there are, email me vpn status
# If not, then disconnect from protonvpn and inform me that the server is free
# protonvpn runs under openvpn
if ps -U root -u root -N | grep -wq vpn
then
	if transmission-remote -l | grep [Dd]ownloading|[Ii]dle
	then
		sudo /usr/bin/protoncpn-cli -s | tee /home/kevin/vpnStatus
		/usr/sbin/ssmtp shocktohp@cock.li < /home/kevin/vpnStatus
		exit
	fi
	sudo /usr/bin/protonvpn-cli -d
	/usr/sbin/ssmtp shocktohp@cock.li < /home/kevin/ShutDownMessage
fi

/usr/sbin/ssmtp shocktohp@cock.li < /home/kevin/jobfired
