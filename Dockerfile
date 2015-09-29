# Originally forked from: git@github.com:gasi/docker-node-hello.git

FROM node:0.10

MAINTAINER qband <q7band@gmail.com>

USER root

ENV AP /data/app
ENV SCPATH /etc/supervisor/conf.d
ENV CNTLM x.x.x.x

## Proxy Setup
RUN printf "Acquire::http::proxy \"http://${CNTLM}:3128\";\nAcquire::https::proxy \"socks5://${CNTLM}:8010\";" > /etc/apt/apt.conf \
	&& git config --global http.proxy http://${CNTLM}:3128 \
	&& git config --global https.proxy socks5://${CNTLM}:8010 \
	&& git config --global http.sslVerify false \
	&& npm config set proxy http://${CNTLM}:3128 \
	&& npm config set https-proxy http://${CNTLM}:3128 \
	&& npm config set strict-ssl false

# The daemons
RUN apt-get -y update \
	&& apt-get -y install supervisor \
	&& mkdir -p /var/log/supervisor

# Supervisor Configuration
ADD ./supervisord/conf.d/* $SCPATH/

# Application Code
ADD src $AP/

WORKDIR $AP

RUN npm update -g \
	&& npm install --save memcached@2.2.0 \
	&& npm install
	&& npm cache clean

CMD ["supervisord", "-n"]
