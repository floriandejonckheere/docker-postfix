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

echo -e "\e[33mSetting correct permissions...\e[0m"
touch /var/log/mail.{log,err,warn} /var/log/spamassassin/spamd.log
chown syslog:adm /var/log/mail.*
chown -R spamd:spamd /var/log/spamassassin
chown -R vmail:vmail /var/mail/

postfix -c /etc/postfix start

echo -e "\e[33mStartup finished\e[0m"
+while true; do
	pidof master &> /dev/null || exit 1
	sleep 5
+done
