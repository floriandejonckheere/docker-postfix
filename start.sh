#!/bin/bash

# Regenerate mappings
postmap /etc/postfix/maps/virtual_domains
postmap /etc/postfix/maps/virtual_users
postmap /etc/postfix/maps/virtual_alias_domains
postmap /etc/postfix/maps/virtual_alias_users

# Start services
service opendkim start
service saslauthd start
service spamassassin start
service postfix start

touch /var/log/mail.log /var/log/mail.err /var/log/mail.warn
tail -F /var/log/mail.* /var/log/spamassassin/spamd.log
