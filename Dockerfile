FROM dhi.io/alpine-base:3.23-alpine3.23-dev

LABEL org.opencontainers.image.source = https://github.com/the-mentor/docker-ftp-server

ENV FTP_USER=foo \
	FTP_PASS=bar \
	GID=1000 \
	UID=1000

RUN apk add --no-cache --update \
    nano \
    vim \
    curl \ 
	vsftpd==3.0.5-r3 

COPY [ "/src/vsftpd.conf", "/etc" ]
COPY [ "/src/docker-entrypoint.sh", "/" ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]
EXPOSE 20/tcp 21/tcp 40000-40009/tcp
HEALTHCHECK CMD netstat -lnt | grep :21 || exit 1
