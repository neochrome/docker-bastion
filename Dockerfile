# vim: ft=dockerfile
FROM alpine:3.1
MAINTAINER Johan Stenqvist <johan@stenqvist.net>
LABEL Description="Bastion with google authenticator"

RUN apk --update add \
		build-base automake autoconf libtool git \
		linux-pam linux-pam-dev \
		libssl1.0 openssl-dev \
	&& mkdir -p /src \
	&& git clone https://github.com/google/google-authenticator.git /src/ga \
		&& (cd /src/ga/libpam \
			&& ./bootstrap.sh \
			&& ./configure \
				--prefix=/ \
			&& make \
			&& make install) \
	&& git clone https://github.com/openssh/openssh-portable.git /src/sshd \
		&& (cd /src/sshd \
			&& git checkout V_7_1_P1 \
			&& autoreconf \
			&& ./configure \
				--prefix=/usr \
				--sysconfdir=/etc/ssh \
				--with-pam \
			&& make \
			&& make install) \
		&& rm -rf /etc/ssh/ssh_host_*_key* \
		&& rm -f /usr/bin/ssh-agent \
		&& rm -f /usr/bin/ssh-keyscan \
	&& rm -rf /src \
	&& apk del build-base automake autoconf libtool git \
		linux-pam-dev \
		openssl-dev \
	&& rm -rf /var/cache/apk/*

COPY ./sshd_config /etc/ssh/
COPY ./sshd.pam /etc/pam.d/sshd
RUN rm -f /etc/motd

ONBUILD RUN ssh-keygen -A

RUN adduser -D -G users -s /bin/sh -h /bastion bastion \
	&& passwd -u bastion
RUN echo '[[ -e .google_authenticator ]] || google-authenticator' >> /etc/profile

EXPOSE 22
CMD /usr/sbin/sshd -De
