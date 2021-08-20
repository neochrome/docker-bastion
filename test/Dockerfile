FROM alpine:3.14.0

RUN apk add \
	openssh-client \
	sshpass

COPY ./test.sh /

CMD ./test.sh
