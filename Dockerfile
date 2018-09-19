FROM docker:18.06

ARG VCS_REF
ARG BUILD_DATE
MAINTAINER Mark Pitman <mark@pitman.bz>
ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN apk update && apk add musl-dev openssh sshpass curl git mercurial bzr go make && go get -v github.com/spf13/hugo && rm -rf $GOPATH/src/* && rm -rf $GOPATH/pkg/* && apk del go curl mercurial bzr
LABEL   org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.vcs-ref=$VCS_REF\
        org.label-schema.vcs-url="https://github.com/mapitman/docker-hugo"

