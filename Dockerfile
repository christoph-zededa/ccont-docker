FROM fedora:latest

ENV DEBIAN_FRONTEND noninteractive

ADD https://github.com/rouming/ccont.git /usr/src/ccont
ADD https://github.com/numactl/numactl.git /usr/src/numa


RUN dnf -y update
RUN dnf -y install make gcc glibc-devel glibc-static autoconf automake libtool

WORKDIR /usr/src/numa
RUN ./autogen.sh
RUN ./configure --enable-static
RUN make -j$(nproc)
RUN  make install

WORKDIR /usr/src/ccont
RUN gcc -o ccont ccont.c -O2 -lpthread -lnuma -lm -lrt -Wall -static
