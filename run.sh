#!/bin/bash

# This command create a container using ALL configuration file overrides
docker run -d --name postfix \
  -v $(pwd)/etc/postfix:/etc/postfix \
  -v $(pwd)/var/mail:/etc/postfix \
  -v $(pwd)/etc/ssl:/etc/ssl \
  -v $(pwd)/etc/opendkim.conf:/etc/opendkim.conf \
  -v $(pwd)/etc/opendkim:/etc/opendkim \
  -v $(pwd)/etc/default/opendkim:/etc/default/opendkim \
  -v $(pwd)/etc/aliases:/etc/aliases \
  -v $(pwd)/etc/mailname:/etc/mailname \
  -v $(pwd)/etc/default/spamassassin:/etc/default/spamassassin \
  -v $(pwd)/etc/spamassassin/local.cf:/etc/spamassassin/local.cf \
  -p 127.0.0.1:125:25 \
  thalarion/postfix
