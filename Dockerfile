FROM alpine:3
LABEL org.label-schema.name="MiniDLNA server" \
    org.label-schema.description="MiniDLNA" \
    org.label-schema.url="https://ivonet.nl/" \
    org.label-schema.vcs-url="https://github.com/ivonet/docker-minidlna" \
    org.label-schema.version="1.0" \
    org.label-schema.schema-version="1.0" \
    maintainer="IvoNet"

ARG MINIDLNA_VERSION=1.3.3-r3

# Install
RUN apk --no-cache add bash curl minidlna=${MINIDLNA_VERSION} minidlna-lang=${MINIDLNA_VERSION} \
  tini shadow su-exec alpine-conf inotify-tools

COPY minidlna.conf /etc/minidlna.conf
COPY entrypoint.sh /entrypoint.sh

ENV MINIDLNA_FRIENDLY_NAME="IvoNet DLNA" \
    MINIDLNA_NOTIFY_INTERVAL=15 \
    MINIDLNA_MEDIA_DIR="V,/videos"

VOLUME ["/minidlna"]
EXPOSE 1900/udp
EXPOSE 8200

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]

HEALTHCHECK --interval=10s --timeout=10s --retries=6 CMD \
  curl --silent --fail 127.0.0.1:8200 || exit 1
