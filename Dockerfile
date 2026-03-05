FROM alpine:3.23

ARG VCS_REF
ARG BUILD_DATE
ARG HUGO_VERSION=0.157.0

LABEL   maintainer="Mark Pitman <mark@pitman.bz>" \
        org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="https://github.com/mapitman/hugo"

RUN apk update && apk add --no-cache openssh sshpass git curl && \
    curl -sSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-amd64.tar.gz" \
      | tar -xz -C /usr/local/bin hugo

