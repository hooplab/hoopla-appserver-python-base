# Dockerfile to build hoopla/hoopla-docker-scala-base
FROM evarga/jenkins-slave
MAINTAINER Halvor Granskogen Bjørnstad <halvor@hoopla.no>

# Install python2.7 and python-pip
RUN apt-get update && \
    apt-get -y install python2.7 python-pip

# Install wkhtmltopdf 0.12.2.1
RUN apt-get install -y libxfont1 xfonts-encodings xfonts-utils xfonts-base xfonts-75dpi && \
    wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
    dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
    rm wkhtmltox-0.12.2.1_linux-trusty-amd64.deb

RUN apt-get -y install wget curl

# Install python packages for build scripts.
RUN pip install sh && \
    pip install logging && \
    pip install setuptools

# Install SWIG, and some python deps.
RUN apt-get install -y swig libpq-dev python-dev libffi-dev

# Install docker-CLI binary. Version 1.1.2 bc. of newest ubuntu repo version
ADD https://get.docker.io/builds/Linux/x86_64/docker-1.7.1 /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

RUN chmod u+w /etc/sudoers && \
    echo "%jenkins ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chmod u-w /etc/sudoers && \
    visudo --check

# Compile git with openssl (not gnutls)
RUN apt-get update && \
    apt-get install -y build-essential fakeroot dpkg-dev && \
    mkdir -p /opt/git-openssl && \
    cd /opt/git-openssl && \
    apt-get source -y git && \
    apt-get build-dep -y git && \
    apt-get install -y libcurl4-openssl-dev && \
    dpkg-source -x git_1.9.1-1ubuntu0.1.dsc && \
    cd git-1.9.1 && \
    ./configure --prefix=/opt && \
    make

# Make our fresh git install available for all users!
RUN ln -s /opt/git-openssl/git-1.9.1/bin-wrappers/git /usr/bin/git
