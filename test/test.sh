#!/bin/sh
ping -c 1 -w 5 bastion
sshpass \
	-P 'Verification code:' \
	-f ./code \
	ssh bastion@bastion \
	-o StrictHostKeyChecking=no \
	-- exit