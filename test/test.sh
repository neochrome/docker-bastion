#!/bin/sh
for i in $(seq 1 10); do
	echo bastion connection attempt [$i/10]
	nc -zvw5 bastion 22 && break
	sleep 1
done
sshpass \
	-P 'Verification code:' \
	-f ./code \
	ssh bastion@bastion \
	-o StrictHostKeyChecking=no \
	-vv \
	-- exit
