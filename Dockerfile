FROM ubuntu
MAINTAINER Halvor Granskogen Bjørnstad <halvor@hoopla.no>

RUN sudo apt-get update && \
    sudo apt-get -y upgrade && \
    sudo apt-get install -y libssl-dev && \
    sudo apt-get -y install python2.7 swig libpq-dev python-dev libffi-dev wget curl && \
    wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py && \
    python /tmp/get-pip.py && \
    pip install sh logging setuptools awscli && \

    # wkhtmltopdf
    apt-get install -y libxfont1 xfonts-encodings xfonts-utils xfonts-base xfonts-75dpi && \
    wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
    dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
    rm wkhtmltox-0.12.2.1_linux-trusty-amd64.deb &&\

    cd /usr/include/openssl/ && \
    sudo ln -s ../x86_64-linux-gnu/openssl/opensslconf.h . && \
    pip install virtualenv --upgrade && \
    mkdir /virtualenvs && \
    virtualenv /virtualenvs/hoopla
