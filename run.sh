#!/bin/bash

docker run -d --name postfix \
  -v /data/postfix/etc/postfix:/etc/postfix \
  -v /data/postfix/var/mail:/etc/postfix \
  -v /data/postfix/etc/ssl:/etc/ssl \
  -p 0.0.0.0:25:25 \
  thalarion/postfix
