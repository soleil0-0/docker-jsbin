# node-jsbin

dockerize jsbin

## Prerequisites

- Node.js

## preparation

1. git submodule init && git submodule update
- find src -type f -exec grep -Iq git:// {} \; -and -print | xargs sed -i 's~git://~https://~g'
- if you use NTLM, please change CNTLM value in Dockerfile.or you can just remove Proxy Setup segment

## command

- docker related
	- build docker image `make build`
	- run docker image as container `make run-container`

- for test
	- install jsbin dependencies `make install`
	- run jsbin in localhost `make run`
	- other
		- delete unused docker containers & images
			- sudo docker ps -a | grep 'minute\|seconds' | awk '{print $1}' | xargs sudo docker rm
            	- sudo docker ps -a -f="exited=0" -q | xargs sudo docker rm
            - sudo docker images | grep \<none\> | awk '{print $3}' | xargs sudo docker rmi

## reference
- [docker-node-hello](https://github.com/spkane/docker-node-hello)
