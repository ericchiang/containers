#!/bin/bash -e

ACI=postgres-latest-linux-amd64.aci

gpg --no-default-keyring --armor -u 5CF0D338 \
    --output "${ACI}.asc" \
    --detach-sig "${ACI}"
