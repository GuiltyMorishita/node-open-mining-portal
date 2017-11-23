FROM node:8.9.1
LABEL Maintainer="Morishita Masataka <m.morishita@altaapps.io>"

WORKDIR /root
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install git
RUN apt-get -y install wget
RUN wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.15.tar.gz
RUN tar -zxvf libsodium-1.0.15.tar.gz
RUN rm libsodium-1.0.15.tar.gz
WORKDIR /root/libsodium-1.0.15
RUN ./configure
RUN make && make check
RUN make install
WORKDIR /root
RUN rm -r libsodium-1.0.15
COPY . /root/nomp
WORKDIR /root/nomp

CMD ["node", "init.js"]
