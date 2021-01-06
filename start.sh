#!/bin/sh
[[ -e /motd ]] \
	&& cp /motd /etc/
[[ -e /authorized_keys ]] \
	&& cp /authorized_keys /bastion/ \
	&& chown bastion:users /bastion/authorized_keys
[[ -e /.google_authenticator ]] \
	&& cp /.google_authenticator /bastion/ \
	&& chown bastion:users /bastion/.google_authenticator \
	&& chmod 0400 /bastion/.google_authenticator
	
ssh-keygen -A \
&& exec /usr/sbin/sshd -De -o LogLevel=$LOG_LEVEL
