ARG ALPINE_VERSION=3.11.3
ARG GA_VERSION=1.08-r0


FROM alpine:$ALPINE_VERSION
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

ARG GA_VERSION
RUN apk add \
	"google-authenticator=$GA_VERSION" \
	openssh-server-pam
RUN rm -f \
	/etc/ssh/ssh_host_*_key* \
	/etc/motd \
	/etc/pam.d/google-authenticator
LABEL com.google.authenticator.version="$GA_VERSION"

ARG VERSION
LABEL version="$VERSION"
COPY ./sshd_config /etc/ssh/
COPY ./sshd.pam /etc/pam.d/sshd
COPY ./start.sh /

VOLUME /etc/ssh /bastion
