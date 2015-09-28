# Originally forked from: git@github.com:gasi/docker-node-hello.git

FROM node:0.10

MAINTAINER qband <q7band@gmail.com>

USER root

ENV AP /data/app
ENV SCPATH /etc/supervisor/conf.d

RUN apt-get -y update

# The daemons
RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

# Supervisor Configuration
ADD ./supervisord/conf.d/* $SCPATH/

# Application Code
ADD src $AP/

WORKDIR $AP

RUN npm install

CMD ["supervisord", "-n"]

