FROM alpine:latest
MAINTAINER Ruben Vermeersch <ruben@rocketeer.be>

ENV GOROOT=/usr/lib/go \
    GOPATH=/gopath     \
    GOBIN=/gopath/bin  \
    PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD main.go /gopath/src/github.com/rubenv/ec2-disable-source-dest/

RUN apk add --update go git openssh && \
    go get -v github.com/rubenv/ec2-disable-source-dest/... && \
    go install -v -ldflags '-w' github.com/rubenv/ec2-disable-source-dest && \
    apk del go git openssh && \
    mv $GOPATH/bin/ec2-disable-source-dest /usr/bin/ && \
    rm -rf $GOPATH && \
    rm -rf /var/cache/apk/*

CMD ["ec2-disable-source-dest"]
