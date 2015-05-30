FROM ubuntu:14.04

MAINTAINER "Florian Dejonckheere <florian@floriandejonckheere.be>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install postfix opendkim opendkim-tools sasl2-bin spamassassin spamc

# Create app structure
RUN mkdir -p /app /var/mail /etc/postfix
WORKDIR /app
ADD start.sh /app/start.sh
RUN chmod a+x /app/start.sh
RUN touch /etc/default/opendkim

# Add vmail user
RUN groupadd -g 5000 vmail && useradd vmail -u 5000 -g vmail -s /sbin/nologin -d /var/mail
RUN chmod 0777 /var/mail
RUN chown -R vmail:vmail /var/mail

# SpamAssassin
RUN groupadd spamd && useradd -g spamd -s /sbin/nologin -d /var/log/spamassassin spamd
RUN mkdir -p /var/log/spamassassin
RUN chown spamd:spamd /var/log/spamassassin

VOLUME /etc/postfix
VOLUME /var/mail

EXPOSE 25

CMD "/app/start.sh"
