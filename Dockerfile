FROM alpine
MAINTAINER Halvor Granskogen Bjørnstad <halvor@hoopla.no>

RUN apk add --update \
    openssl-dev \
    python \
    libpq \
    python-dev \
    libffi-dev \
    wget \
    curl \
    vim \
    bash \
 && rm -rf /var/cache/apk/*

# Install wkhtmltopdf from testing repository
# TODO: wait for it to be added to the main repository
RUN apk add --update \
    --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    wkhtmltopdf \
 && rm -rf /var/cache/apk/*1

RUN wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py && \
    python /tmp/get-pip.py && \
    pip install sh logging setuptools awscli virtualenv --upgrade && \
    mkdir /virtualenvs && \
    virtualenv /virtualenvs/hoopla
