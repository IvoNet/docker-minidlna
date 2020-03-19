FROM alpine:3.11
ARG VERSION=1.0
LABEL org.label-schema.name="MiniDLNA server" \
    org.label-schema.description="MiniDLNA" \
    org.label-schema.url="https://ivonet.nl/" \
    org.label-schema.vcs-url="https://github.com/ivonet/docker-minidlna" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0" \
    maintainer="Ivonet - @ivonet"

RUN apk --no-cache add minidlna

ADD minidlna.conf /etc/minidlna.conf

EXPOSE 1900/udp
EXPOSE 8200


ENTRYPOINT [ "/usr/sbin/minidlnad", "-S" ]
