#!/usr/bin/env bash

docker build -t autossl $PWD
docker run -it --rm \
	--publish 53:53/tcp \
	--publish 53:53/udp \
	--volume $PWD/certs:/dehydrated/certs \
	--volume $PWD/accounts:/dehydrated/accounts \
	autossl
