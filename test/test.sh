#!/bin/sh
for i in $(seq 1 10); do
	echo "=============================="
	echo "connection attempt [$i/10]"
	echo "=============================="
	nc -zvw5 bastion 22 && break
	sleep 1
done
echo "=============================="
echo "login attempt, code: $(cat /code)"
echo "=============================="
sshpass \
	-P 'Verification code:' \
	-f /code \
	ssh bastion@bastion \
	-o StrictHostKeyChecking=no \
	-vv \
	-- exit
