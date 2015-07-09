FROM ubuntu:14.04

MAINTAINER "Florian Dejonckheere <florian@floriandejonckheere.be>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get -y install supervisor postfix opendkim opendkim-tools sasl2-bin spamassassin spamc

# Create app structure
RUN mkdir -p /app/ /var/mail/ /etc/postfix/maps/
ADD start.sh /app/start.sh
RUN chmod a+x /app/start.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add vmail user
RUN groupadd -g 5000 vmail && useradd vmail -u 5000 -g vmail -s /sbin/nologin -d /var/mail/
RUN chmod 770 /var/mail/
RUN chown -R vmail:vmail /var/mail/

# OpenDKIM
RUN usermod -aG opendkim postfix
RUN mkdir -p /var/run/opendkim/ /var/log/dkim-stats/
RUN chown -R opendkim:opendkim /var/run/opendkim/ /var/log/dkim-stats/

# SpamAssassin
RUN groupadd spamd && useradd -g spamd -s /sbin/nologin -d /var/run/spamassassin/ spamd
RUN mkdir /var/run/spamassassin/
RUN chown spamd:spamd /var/run/spamassassin/

VOLUME /var/mail/

EXPOSE 25 587

CMD /usr/bin/supervisord
