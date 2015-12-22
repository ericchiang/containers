.PHONY: build clean

build: rootfs.tar
	docker build -t quay.io/ericchiang/postgres:9.4.5 .
	docker tag quay.io/ericchiang/postgres:9.4.5 quay.io/ericchiang/postgres:latest 
