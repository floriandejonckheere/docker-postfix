.DEFAULT_GOAL := all

ldap-domains:
	cat ldap-server.conf ldap-domains.conf > ldap-domains

ldap-users:
	cat ldap-server.conf ldap-users.conf > ldap-users

ldap-alias-domains:
	cat ldap-server.conf ldap-alias-domains.conf > ldap-alias-domains

ldap-alias-users:
	cat ldap-server.conf ldap-alias-users.conf > ldap-alias-users

all: ldap-domains ldap-users ldap-alias-domains ldap-alias-users

default: all

clean:
	rm ldap-domains ldap-users ldap-alias-domains ldap-alias-users
