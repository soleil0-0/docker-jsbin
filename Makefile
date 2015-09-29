install:
	cd src && npm install --save memcached@2.2.0 && npm install

build:
	docker build -t qband/docker-jsbin:latest .

run:
	cd src && npm start

run-container:
	docker run --name jsbin -it -p 8082:3000 qband/docker-jsbin

test:
	curl localhost:8082

clean:
	rm -rf src/node_modules


.PHONY: install build run test clean
