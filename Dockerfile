FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /tmp/

#Install Dependencies
RUN apt-get -y update && \
    apt-get -y install sharutils tzdata gawk libc-ares2 && \
    apt-get -y install libavahi-compat-libdnssd-dev && \
    apt-get -y install libxml2 libarchive-dev curl && \
    apt-get -y install libcurl4-openssl-dev

#Install z-Wave
RUN wget http://razberry.z-wave.me/z-way-server/z-way-server-Ubuntu-v2.3.6.tgz && \
    tar -zxf z-way-server-Ubuntu-v2.3.6.tgz -C /opt && \

EXPOSE 8083
CMD export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/z-way-server/libs && /opt/z-way-server/z-way-server