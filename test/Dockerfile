FROM alpine:3.19.1

RUN apk add \
	openssh-client \
	sshpass

COPY ./test.sh /

CMD ./test.sh
