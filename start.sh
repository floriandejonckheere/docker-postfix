#!/bin/bash

function handler() {
  echo -e "\e[31mError on line $LINENO\e[0m"
  exit 1
}

trap handler ERR

echo -e "\e[33mRegenerating virtual mappings...\e[0m"
newaliases
postmap /etc/postfix/maps/virtual_domains
postmap /etc/postfix/maps/virtual_users
postmap /etc/postfix/maps/virtual_alias_domains
postmap /etc/postfix/maps/virtual_alias_users

# Allow OpenDKIM and SA to start up
sleep 5
echo -e "\e[33mStarting Postfix...\e[0m"
postfix start

# Allow postfix to spawn its minions
sleep 5

while true; do
	# Wait for postfix' master daemon
	pidof master &>/dev/null || exit 1
	sleep 5
done
