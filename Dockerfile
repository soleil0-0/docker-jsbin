# Originally forked from: git@github.com:gasi/docker-node-hello.git

FROM node:0.10

MAINTAINER qband <q7band@gmail.com>

#USER root

ENV AP /data/app
ENV SCPATH /etc/supervisor/conf.d
ENV CNTLM x.x.x.x

## if CNTLM exist, then setup proxy in apt-get, git, and npm
RUN if [ "${CNTLM}" != "" ]; then \
		printf "Acquire::http::proxy \"http://${CNTLM}:3128\";\nAcquire::https::proxy \"socks5://${CNTLM}:8010\";" > /etc/apt/apt.conf \
		&& git config --global http.proxy http://${CNTLM}:3128 \
		&& git config --global https.proxy socks5://${CNTLM}:8010 \
		&& git config --global http.sslVerify false \
		&& npm config set proxy http://${CNTLM}:3128 \
		&& npm config set https-proxy http://${CNTLM}:3128 \
		&& npm config set registry http://registry.npmjs.org \
		&& npm config set strict-ssl false ;\
	fi

## check configuration of git & npm
#RUN git config --list --global \
#		&& npm config list

# The daemons
RUN apt-get -y update \
	&& apt-get -y install apt-utils supervisor \
	&& mkdir -p /var/log/supervisor

# Supervisor Configuration
ADD ./supervisord/conf.d/* $SCPATH/

# Application Code
ADD src $AP/

WORKDIR $AP
ENV JSBIN_CONFIG $AP/config.default.json

RUN npm update -g \
	&& npm uninstall --save-optional zmq \
	&& npm i -S memcached@2.2.0 connect \
	&& npm i

#CMD ["supervisord", "-n"]
CMD ["node", "./bin/jsbin"]
