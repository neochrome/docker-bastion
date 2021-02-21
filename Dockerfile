FROM alpine:3.13.2
ENV LOG_LEVEL=INFO

LABEL \
	maintainer="johan@stenqvist.net" \
	description="Bastion with google authenticator"

EXPOSE 22
CMD /start.sh

RUN \
	adduser -D -G users -s /bin/sh -h /bastion bastion \
	&& passwd -u bastion
RUN echo '[[ -e .google_authenticator ]] || google-authenticator' >> /etc/profile

RUN apk add \
	google-authenticator \
	openssh-server-pam
RUN rm -f \
	/etc/ssh/ssh_host_*_key* \
	/etc/motd \
	/etc/pam.d/google-authenticator

ARG VERSION
LABEL version="$VERSION"
COPY ./sshd_config /etc/ssh/
COPY ./sshd.pam /etc/pam.d/sshd
COPY ./start.sh /

VOLUME /etc/ssh /bastion
