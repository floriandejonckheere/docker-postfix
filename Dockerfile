FROM ubuntu:14.04

MAINTAINER "Florian Dejonckheere <florian@floriandejonckheere.be>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install postfix opendkim opendkim-tools mailutils sasl2-bin

# Create app structure
RUN mkdir -p /app /var/mail /etc/postfix
WORKDIR /app
ADD start.sh /app/start.sh
RUN chmod a+x /app/start.sh

# Add vmail user
RUN groupadd vmail && useradd vmail -g vmail -s /sbin/nologin -d /var/mail
RUN chmod 0777 /var/mail
RUN chown -R vmail:vmail /var/mail

VOLUME /etc/postfix
VOLUME /var/mail

EXPOSE 25

CMD "/app/start.sh"
