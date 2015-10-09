# node-jsbin

if you install in this way `npm i -g jsbin`, jsbin is not the latest, is a very old version.  
So this repository provide a way to run latest jsbin locally by means of dockerizing jsbin

## Prerequisites

- Node.js
- SuperVisor
	- sudo apt-get install supervisor

## Preparation

1. get git submodule source code
	- git submodule init && git submodule update
- replace https link with http
	- find src -type f -exec grep -Iq git:// {} \; -and -print | xargs sed -i 's~git://~https://~g'
- change js, css link from absolute path to relative path
	- sed -i "s~app\.set('url full'.*~app\.set('url full', options\.url\.prefix);~" src/lib/app.js
	- sed -i "s~return path ? proto + ':\/\/' + root + '\/' + (path || '') : proto + ':\/\/' + root;~return path? path: '';~" src/lib/helpers.js
- if you use NTLM, please change CNTLM value `ENV CNTLM x.x.x.x` in Dockerfile.or you can just remove that line.

## Command

- docker related
	- build docker image `sudo make build`
		- if src/ folder is dirty, then run command `make clean`
	- run docker image as container `sudo make run-container`

- for test
	- install jsbin dependencies `make install`
	- run
		- run jsbin in localhost `make run`. Pay attention that jsbin only support `0.10 <= node version < 0.12` now
		- run in supervisord `sudo make run-sp`
	- clean test files `make clean`
	- other
		- delete unused docker containers & images
			- sudo docker ps -a | grep 'minute\|seconds\|jsbin' | awk '{print $1}' | xargs sudo docker rm
            	- sudo docker ps -a -f="exited=0" -q | xargs sudo docker rm
            - sudo docker images | grep '\<none\>\|qband/docker-jsbin' | awk '{print $3}' | xargs sudo docker rmi
        - delete unused docker log file
            - find . -name 'docker.*.log' | sort | wc -l
            - find . -name 'docker.*.log' | sort | head -n X | xargs rm -f
            - find . -name 'docker.*.log' | sort | tail -n X | xargs rm -f

## known issues

- can't save
	- [https://github.com/jsbin/jsbin/issues/2448](https://github.com/jsbin/jsbin/issues/2448)

## Reference
- [docker-node-hello](https://github.com/spkane/docker-node-hello)
- [jsbin branch that has Dockerfile](https://github.com/jsbin/jsbin/tree/254ceb59f4d415948e0a8eac255e2dfe5d0ae353)
