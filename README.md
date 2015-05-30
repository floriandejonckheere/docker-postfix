# Docker Postfix

## Configuration

### Postfix

A custom configuration directory is provided in `etc/postfix`. It contains a default postfix setup with TLS, DKIM and a flat user database. Customize as needed, the most interesting settings are near the bottom of `main.cf`.

### TLS

Put your SSL/TLS RSA keys in `etc/ssl/` as `postfix.pem` and `postfix.key`. Make sure they have correct permissions.

### OpenDKIM

Put your DKIM key in `etc/ssl/` as `dkim.key`. Make sure it has the correct permissions. Adjust the file `etc/opendkim.conf` to match your key.

### SpamAssassin

## Build

```
$ ./build.sh
```

## Execution

This creates a container using ALL overrides in `etc/`
```
$ ./run.sh
```
