# Docker Postfix

This Dockerfile provides a container running Postfix over TLS, OpenDKIM, SpamAssassin in a multi-domain setup.

## Configuration

### Postfix

The included configuration files are setup for a fully virtual system. To enable receiving on your local domain, edit `etc/postfix/main.cf` and `etc/mailname`. Define your virtual domains, users and aliases in `etc/postfix/maps/`.

A custom configuration directory is provided in `etc/postfix`. It contains a default postfix setup with TLS, DKIM and a flat user database. Customize as needed, the most interesting settings are near the bottom of `main.cf`.

### TLS

Put your SSL/TLS RSA keys in `etc/ssl/` as `postfix.pem` and `postfix.key`. Make sure they have correct permissions set.

### OpenDKIM

Add your IP addresses to `etc/opendkim/TrustedHosts`. Place your keys in `etc/ssl/dkim/` or generate them by running `opendkim-genkey -r -d mydomain.com`. Use whatever hierachy you desire, but make sure the keys have the correct permissions set. Edit the `etc/opendkim/KeyTable` and `etc/opendkim/SigningTable` files to reflect the domain-key mapping. Don't forget to set your domain's TXT record.

### SpamAssassin

No configuration is needed.

## Build

```
$ ./build.sh
```

## Execution

This creates a container using ALL overrides in `etc/`
```
$ ./run.sh
```
