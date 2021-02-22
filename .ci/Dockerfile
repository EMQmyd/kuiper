FROM golang:1.15.1 AS builder

COPY . /go/kuiper

WORKDIR /go/kuiper

RUN apt-get update \
    && apt-get install -y --no-install-recommends apt-utils zip upx pkg-config libczmq-dev build-essential debhelper \
    && make -C /go/kuiper pkg

RUN dpkg -i _packages/*.deb \
    && [ "$(dpkg -l |grep kuiper |awk '{print $1}')" = "ii" ] \
    &&  dpkg -r kuiper \
    &&  [ "$(dpkg -l |grep kuiper |awk '{print $1}')" = "rc" ] \
    && dpkg -P kuiper \
    && [ -z "$(dpkg -l |grep kuiper)" ]
