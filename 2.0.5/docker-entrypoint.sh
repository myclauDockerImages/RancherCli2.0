#!/bin/bash
set -e
if [ "${RANCHER_TOKEN}" == $null ]; then 
echo RANCHER_TOKEN cannot be empty
exit 1
fi
if [ "${RANCHER_URL}" == $null ]; then
echo RANCHER_URL cannot be empty
exit 1
fi


if [ "${RANCHER_CA_CERT}" != "$null" ]; then
echo "-----BEGIN CERTIFICATE-----\n" > /cert.crt
echo "${RANCHER_CA_CERT}" >> /cert.crt
echo "-----END CERTIFICATE-----\n" >> /cert.crt
extraloginopt=--cacert=/cert.crt
fi

if [ "${RANCHER_DEFAULT_CLUSTER}" != "$null" ]; then
curl -k -u "${RANCHER_TOKEN}" \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
-d '{}' \
"${RANCHER_URL}/clusters/${RANCHER_DEFAULT_CLUSTER}?action=generateKubeconfig" > output
cat output | jq -r .config > kubeconfig

sed -i 's/\\n/\n/g'  kubeconfig
sed -i 's/\\\\/\\/g'  kubeconfig
sed -i 's/\\"/"/g'  kubeconfig
mkdir -p ~/.kube
mv ./kubeconfig  ~/.kube/config
fi

#default select 1
echo ${DEFAULT_PROJECT-1} | rancher login --token ${RANCHER_TOKEN} ${extraloginopt-}  ${RANCHER_URL}


# if ENABLE_KUBECONFIG=

exec "$@"

