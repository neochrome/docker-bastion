#!/bin/sh
[[ -e /motd ]] \
	&& echo "Applying supplied motd" \
	&& cp /motd /etc/
[[ -e /authorized_keys ]] \
	&& echo "Applying supplied authorized_keys" \
	&& cp /authorized_keys /bastion/ \
	&& chown bastion:users /bastion/authorized_keys
[[ -e /.google_authenticator ]] \
	&& echo "Applying supplied google authenticator settings" \
	&& cp /.google_authenticator /bastion/ \
	&& chown bastion:users /bastion/.google_authenticator \
	&& chmod 0400 /bastion/.google_authenticator
	
ssh-keygen -A \
	&& exec /usr/sbin/sshd.pam -De -o LogLevel=$LOG_LEVEL
