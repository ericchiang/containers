#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]; then
    # require root so the tar has the correct file permissions
    echo "This script uses functionality which requires root privileges"
    exit 1
fi

mkdir -p rootfs
tar -xf postgres_rootfs.tar -C rootfs
acbuild begin ./rootfs
rm -rf rootfs

trap "{ export EXT=$?; acbuild end && exit $EXT; }" EXIT

acbuild set-name quay.io/ericchiang/postgres
acbuild run -- mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql
acbuild copy entrypoint.sh /entrypoint.sh
acbuild copy run.sh /run.sh
acbuild port add postgres tcp 5432
acbuild environment add PG_MAJOR 9.4
acbuild environment add PG_VERSION 9.4.5
acbuild environment add PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
acbuild environment add PGDATA /var/lib/postgresql/data
acbuild set-exec /entrypoint.sh
acbuild write --overwrite postgres-latest-linux-amd64.aci
