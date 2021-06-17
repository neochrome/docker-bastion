FROM alpine:3.13.5

RUN apk add \
	openssh-client \
	sshpass

COPY ./test.sh /

CMD ./test.sh
