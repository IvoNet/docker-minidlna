FROM alpine:3.11
ARG VERSION=1.0
LABEL org.label-schema.name="MiniDLNA server" \
    org.label-schema.description="MiniDLNA" \
    org.label-schema.url="https://ivonet.nl/" \
    org.label-schema.vcs-url="https://github.com/ivonet/docker-minidlna" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    maintainer="Ivonet - @ivonet"

RUN apk --no-cache add minidlna bash tini
COPY minidlna.conf /etc/minidlna.conf
COPY entrypoint.sh /entrypoint.sh

ENV MINIDLNA_FRIENDLY_NAME="IvoNet DLNA" \
    MINIDLNA_NOTIFY_INTERVAL=30 \
    MINIDLNA_MEDIA_DIR="V,/videos"

VOLUME ["/var/lib/minidlna"]
EXPOSE 1900/udp
EXPOSE 8200

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
