#!/bin/bash
set -e

if [ "${RANCHER_CA_CERT}" != "$null" ]; then
echo "-----BEGIN CERTIFICATE-----\n" > /cert.crt
echo "${RANCHER_CA_CERT}" >> /cert.crt
echo "-----END CERTIFICATE-----\n" >> /cert.crt
extraloginopt=--cacert=/cert.crt
fi

#default select 1
echo ${DEFAULT_PROJECT-1} | rancher login --token ${RANCHER_TOKEN} ${extraloginopt-}  $RANCHER_URL


exec "$@"

