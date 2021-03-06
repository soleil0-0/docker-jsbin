install:
	cd src \
		&& npm install --save memcached@2.2.0 \
		&& npm install

build:
	docker build -t qband/jsbin:latest . > docker.$(shell date +%Y%m%d-%H%M%S).log

run:
	cd src \
		&& npm start

run-container:
	docker run --name jsbin \
		-d -p 8082:3000 \
		qband/jsbin
#		-e CNTLM=x.x.x.x \

run-sp:
	mkdir -p /var/log/supervisor \
		&& cp supervisord/conf.d/* /etc/supervisor/conf.d \
		&& sed -i "s~directory=.*~directory=$(shell pwd)/src~" /etc/supervisor/conf.d/node.conf \
		&& sed -i "s~command=/usr/local/bin/node .*~command=/usr/local/bin/npm start~" /etc/supervisor/conf.d/node.conf \
		&& JSBIN_CONFIG=$(shell pwd)/src/config.default.json
		&& supervisord -n

test:
	wget --spider localhost:8082

clean:
	rm -rf src/node_modules \
#		&& sudo rm -rf /var/log/supervisor \
#		&& sudo rm -rf /etc/supervisor/conf.d/*

.PHONY: install run test clean
