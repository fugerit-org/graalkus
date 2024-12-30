#!/usr/bin/env bash
#
# Apply all openshift templates at once
#
# for instance :
#
# ' ./src/main/openshift/oc-apply-all.sh fugerit-dev apps.rm3.7wse.p1.openshiftapps.com'

function applyAll() {

  # Check for necessary parameters
  if [ $# -ne 2 ]; then
    echo "Usage: oc-apply-all.sh <NAMESPACE> <CLUSTER_DOMAIN>"
    return 1 # Wrong number of params
  fi

  BASE_DIR=src/main/openshift

  TEMP_DIR=target

  PROJECT_NAME=$1
  CLUSTER_DOMAIN=$2

  # script list
  scripts=("graalkus-jit-deploy.yml" "graalkus-aot-pgo-deploy.yml" "graalkus-aot-deploy.yml" "graalkus-ingress-simple.yml")

  # iterate over scripts
  for script in "${scripts[@]}"; do
    echo "**** Run script : $script ***"
    CURRENT_FILE=${BASE_DIR}/$script
    SCRIPT_FILE=${TEMP_DIR}/$script
    cp $CURRENT_FILE $SCRIPT_FILE
    sed -i "s/<PROJECT_NAME>/$PROJECT_NAME/g; s/<CLUSTER_DOMAIN>/$CLUSTER_DOMAIN/g" "$SCRIPT_FILE"
    oc apply -f ${SCRIPT_FILE}
  done

  return 0

}

applyAll $1 $2
EXIT=$?
echo "exit : $EXIT"
exit $EXIT



