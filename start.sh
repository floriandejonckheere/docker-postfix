#!/bin/bash

service opendkim start
service saslauthd start
service spamassassin start
service postfix start

touch /var/log/mail.log /var/log/mail.err /var/log/mail.warn
tail -F /var/log/mail.* /var/log/spamassassin/spamd.log
