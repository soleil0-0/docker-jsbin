install:src
	mkdir -p src/node_modules && npm install src

build:
	docker build -t qband/docker-jsbin:latest .

run:
	cd src && npm start

run-container:
	docker run --name jsbin -p 8082:3000 -d qband/docker-jsbin

test:
	curl localhost:8082

clean:
	rm -rf src/node_modules


.PHONY: install build run test clean
