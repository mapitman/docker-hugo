FROM docker:latest
MAINTAINER Mark Pitman <mark@pitman.bz>
ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN apk update && apk add curl git mercurial bzr go && go get -v github.com/spf13/hugo && rm -rf $GOPATH/src/* && rm -rf $GOPATH/pkg/* && apk del go curl mercurial bzr && rm -rf /var/cache/apk/*