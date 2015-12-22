.PHONY: build clean

postgres_rootfs.tar:
	wget https://github.com/ericchiang/containers/releases/download/postgres_v9.4.5/postgres_rootfs.tar

build: postgres_rootfs.tar
	docker build -t quay.io/ericchiang/postgres:9.4.5 .
	docker tag quay.io/ericchiang/postgres:9.4.5 quay.io/ericchiang/postgres:latest 
