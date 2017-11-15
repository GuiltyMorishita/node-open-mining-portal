FROM node:8.9.1
LABEL Maintainer="Morishita Masataka <m.morishita@altaapps.io>"

WORKDIR /root
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install git
RUN apt-get -y install wget
RUN wget https://download.libsodium.org/libsodium/releases/libsodium-stable-2017-11-15.tar.gz
RUN tar -zxvf libsodium-stable-2017-11-15.tar.gz
RUN rm libsodium-stable-2017-11-15.tar.gz
WORKDIR /root/libsodium-stable
RUN ./configure
RUN make && make check
RUN make install
WORKDIR /root
RUN rm -r libsodium-stable
COPY . /root/nomp
WORKDIR /root/nomp
RUN npm install

CMD ["node", "init.js"]
