# node-jsbin

dockerize jsbin

## Prerequisites

- Node.js

## preparation

1. git submodule init && git submodule update
- sed -i 's~git://github.com/3rd-Eden/node-memcached~3rd-Eden/node-memcached~' src/package.json
- find src -type f -exec grep -Iq git:// {} \; -and -print | xargs sed -i 's~git://~https://~g'
- if you use NTLM, please change CNTLM value in Dockerfile.or you can just remove Proxy Setup segment

## delete unused docker containers & images

- sudo docker ps -a | grep 'minute\|seconds' | awk '{print $1}' | xargs sudo docker rm
	- sudo docker ps -a -f="exited=0" -q | xargs sudo docker rm
- sudo docker images | grep \<none\> | awk '{print $3}' | xargs sudo docker rmi

## reference
- [docker-node-hello](https://github.com/spkane/docker-node-hello)
