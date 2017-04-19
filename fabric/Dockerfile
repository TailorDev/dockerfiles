FROM tailordev/rsync:latest
MAINTAINER TailorDev <hello@tailordev.fr>

RUN apk update && \
    apk add openssh python2 git && \
    apk --update add --virtual build-dependencies openssl-dev python-dev libffi-dev py-pip build-base && \
    pip install --upgrade fabric && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*
