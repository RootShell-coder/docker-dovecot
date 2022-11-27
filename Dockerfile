FROM debian:stable

LABEL authors="darkman"
LABEL maintainer="RootShell-coder <Root.Shelling@gmail.com>"

ARG USERNAME=ohmyroot
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && apt update && apt upgrade -y \
    && apt install dovecot-lmtpd dovecot-managesieved \
    dovecot-sieve dovecot-pgsql dovecot-imapd dovecot-pop3d dovecot-antispam openssl rspamd sudo -y \
    && apt autoremove \
    && usermod -aG dovecot ${USERNAME} \
    && echo ${USERNAME} "ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && rm -rf /var/lib/apt/lists /tmp/*

COPY docker-entrypoint.sh /usr/local/bin
#COPY dovecot /etc/dovecot
RUN chmod +x /usr/local/bin/docker-entrypoint.sh \
    && mkdir -m 777 -p /srv/vmail

USER ${USERNAME}
WORKDIR /etc/dovecot
VOLUME [ "/etc/dovecot", "/srv/vmail"]
EXPOSE 110 143 995 993
ENTRYPOINT ["docker-entrypoint.sh"]
#CMD ["dovecot", "-F" ]
