#!/bin/sh
set -e

mkdir -p "$PGDATA"
chown -R postgres "$PGDATA"

su postgres -c './run.sh'
