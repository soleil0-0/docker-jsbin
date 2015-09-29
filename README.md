# node-jsbin

dockerize jsbin

## Prerequisites

- Node.js
- SuperVisor
	- sudo apt-get install supervisor

## Preparation

1. git submodule init && git submodule update
- find src -type f -exec grep -Iq git:// {} \; -and -print | xargs sed -i 's~git://~https://~g'
- if you use NTLM, please change CNTLM value in Dockerfile.or you can just remove Proxy Setup segment

## Command

- docker related
	- build docker image `sudo make build`
		- if src/ folder is dirty, then run command `make clean`
	- run docker image as container `sudo make run-container`

- for test
	- install jsbin dependencies `make install`
	- run
		- run jsbin in localhost `make run`
		- run in supervisord `sudo make run-sp`
	- clean test files `make clean`
	- other
		- delete unused docker containers & images
			- sudo docker ps -a | grep 'minute\|seconds' | awk '{print $1}' | xargs sudo docker rm
            	- sudo docker ps -a -f="exited=0" -q | xargs sudo docker rm
            - sudo docker images | grep '\<none\>\|qband/docker-jsbin' | awk '{print $3}' | xargs sudo docker rmi

## Reference
- [docker-node-hello](https://github.com/spkane/docker-node-hello)
