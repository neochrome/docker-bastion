#!/bin/sh
[[ -e /motd ]] \
	&& cp /motd /etc/
[[ -e /authorized_keys ]] \
	&& cp /authorized_keys /bastion/ \
	&& chown bastion:users /bastion/authorized_keys

ssh-keygen -A \
&& exec /usr/sbin/sshd -De -o LogLevel=$LOG_LEVEL
