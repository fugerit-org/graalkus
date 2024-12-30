#!/usr/bin/env bash
#
# Apply all openshift templates at once

BASE_DIR=src/main/openshift

TEMP_DIR=target

PROJECT_NAME=fugerit-dev
CLUSTER_DOMAIN=apps.rm3.7wse.p1.openshiftapps.com

# script list
scripts=("graalkus-jit-deploy.yml" "graalkus-jit-hpas.yml")

# iterate over scripts
for script in "${scripts[@]}"; do
  echo "**** Run script : $script ***"
  CURRENT_FILE=${BASE_DIR}/$script
  SCRIPT_FILE=${TEMP_DIR}/$script
  cp $CURRENT_FILE $SCRIPT_FILE
  sed -i "s/<PROJECT_NAME>/$PROJECT_NAME/g; s/<CLUSTER_DOMAIN>/$CLUSTER_DOMAIN/g" "$SCRIPT_FILE"
  oc apply -f ${SCRIPT_FILE}
done

