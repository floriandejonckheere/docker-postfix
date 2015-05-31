#!/bin/bash

function handler() {
  echo -e "\e[31mError on line $LINENO\e[0m"
  exit 1
}

trap handler ERR

echo -e "\e[33mRegenerating virtual mappings...\e[33m"
postmap /etc/postfix/maps/virtual_domains
postmap /etc/postfix/maps/virtual_users
postmap /etc/postfix/maps/virtual_alias_domains
postmap /etc/postfix/maps/virtual_alias_users

echo -e "\e[33mStarting OpenDKIM...\e[33m"
service opendkim start
echo -e "\e[33mStarting saslauthd...\e[33m"
#~ service saslauthd start
echo -e "\e[33mStarting SpamAssassin...\e[33m"
service spamassassin start
echo -e "\e[33mStarting Postfix...\e[33m"
service postfix start

touch /var/log/mail.log /var/log/mail.err /var/log/mail.warn /var/log/spamassassin/spamd.log

echo -e "\e[33mStartup finished\e[33m"
tail -F /var/log/mail.* /var/log/spamassassin/spamd.log
