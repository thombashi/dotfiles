#!/bin/sh

set -eux

INSTALL_DIR=${HOME}/gcloud/google-cloud-sdk
TMP_DIR=$(mktemp -d)
INSTALL_SCRIPT=${TMP_DIR}/install.sh

trap 'rm -rf ${TMP_DIR}' 0 1 2 3 15

mkdir -p $INSTALL_DIR
curl https://sdk.cloud.google.com > ${INSTALL_SCRIPT}
bash ${INSTALL_SCRIPT} --disable-prompts --install-dir="${INSTALL_DIR}"
