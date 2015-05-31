#!/bin/bash

# Use absolute paths, don't append slash
BASEDIR="$(pwd)"
CONFDIR="${BASEDIR}/etc"
DATADIR="${BASEDIR}/var"

# This command create a container using ALL configuration file overrides
docker run -d --name postfix \
  -v ${CONFDIR}/postfix/main.cf:/etc/postfix/main.cf \
  -v ${CONFDIR}/postfix/master.cf:/etc/postfix/master.cf \
  -v ${CONFDIR}/postfix/maps/:/etc/postfix/maps/ \
  -v ${CONFDIR}/ssl/:/etc/ssl/ \
  -v ${CONFDIR}/mailname:/etc/mailname \
  -v ${CONFDIR}/opendkim.conf:/etc/opendkim.conf \
  -v ${CONFDIR}/opendkim/:/etc/opendkim/ \
  -v ${CONFDIR}/default/opendkim:/etc/default/opendkim \
  -v ${CONFDIR}/default/spamassassin:/etc/default/spamassassin \
  -v ${CONFDIR}/spamassassin/local.cf:/etc/spamassassin/local.cf \
  -v ${DATADIR}/mail/:/var/mail/ \
  -p 0.0.0.0:25:25 \
  thalarion/postfix
