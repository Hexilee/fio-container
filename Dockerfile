FROM alpine:3.13
MAINTAINER Hexilee <i@hexilee.me>

ARG VERSION=3.25
ARG FOLDER_NAME=fio-fio-"$VERSION"

RUN apk --no-cache add libaio && \
    apk --no-cache add --virtual build-dependencies \
        libaio-dev \
        zlib-dev \
        build-base \
        linux-headers \
        coreutils && \
    wget -c https://codeload.github.com/axboe/fio/tar.gz/fio-"$VERSION" -O - | tar -xz -C /root && \
    cd /root/"$FOLDER_NAME" && \
    ./configure && \
    make -j "$(nproc)" && \
    make install && \
    rm -rf /root/"$FOLDER_NAME" && \
    apk del build-dependencies

COPY job.fio /job.fio
RUN chmod 400 /job.fio
RUN mkdir /test

CMD ["fio", "/job.fio"]
