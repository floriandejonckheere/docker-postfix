# Docker Postfix

This Dockerfile provides a container running Postfix over TLS, OpenDKIM, SpamAssassin in a multi-domain setup.

## Configuration

### Postfix

The included configuration files are setup for a fully virtual system. To enable receiving on your local domain, edit `etc/postfix/main.cf` and `etc/mailname`.

**Flat file**

Define your virtual domains, users and aliases in `etc/postfix/maps/`.

**LDAP**

Define your LDAP connection settings and scheme in `etc/posfix/ldap/*.conf`. Run `make` to generate the correct output files. Don't forget to use `postmap` to test your settings before deploying them! Enable the *LDAP* section at the bottom of `etc/postfix/main.cf`.

### TLS

Put your SSL/TLS RSA keys in `etc/ssl/` as `postfix.pem` and `postfix.key`. Make sure they have correct permissions set.

### OpenDKIM

Add your IP addresses to `etc/opendkim/TrustedHosts`. Place your keys in `etc/ssl/dkim/` or generate them by running `opendkim-genkey -r -d mydomain.com`. Use whatever hierachy you desire, but make sure the keys have the correct permissions set. Edit the `etc/opendkim/KeyTable` and `etc/opendkim/SigningTable` files to reflect the domain-key mapping. It is possible to use the same key for all outgoing domains, refer to (this StackOverflow thread)[http://serverfault.com/questions/52830/dkim-sign-outgoing-mail-from-any-domain-with-postfix-and-ubuntu].

Don't forget to set your domain's TXT record.

### SpamAssassin

Set the system's name and contact address in `etc/spamassassin/local.cf`.

## Build

```
$ ./build.sh
```

## Execution

This creates a container using ALL overrides in `etc/`
```
$ ./run.sh
```
