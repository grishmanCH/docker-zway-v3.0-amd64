FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive
ENV zversion=2.3.6

WORKDIR /tmp/

#Install Dependencies
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install sharutils tzdata gawk libc-ares2 && \
    apt-get -y install libavahi-compat-libdnssd-dev && \
    apt-get -y install libxml2 libarchive-dev curl && \
    apt-get -y install libcurl4-openssl-dev && \
    apt-get -y autoremove && apt-get -y autoclean && \
    rm -rf /var/lib/apt/lists/*

#Install z-Wave
RUN apt-get -y update && \
    apt-get -y install wget && \
    wget http://razberry.z-wave.me/z-way-server/z-way-server-Ubuntu-v${zversion}.tgz && \
    tar -zxf z-way-server-Ubuntu-v${zversion}.tgz -C /opt && \
    apt-get -y remove wget && \
    apt-get -y autoremove && apt-get -y autoclean && \
    rm -rf /var/lib/apt/lists/*

VOLUME /opt/z-way-server/config
VOLUME /var/log

EXPOSE 8083
CMD export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/z-way-server/libs && /opt/z-way-server/z-way-server