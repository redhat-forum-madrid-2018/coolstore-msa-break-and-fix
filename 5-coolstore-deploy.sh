#!/bin/bash

# Environment
. ./0-environment.sh

ISTIO_HOME=${PWD}/istio-${ISTIO_VERSION}

oc process -f ./openshift/coolstore-msa-break-fix-template.yaml | \
 ${ISTIO_HOME}/bin/istioctl kube-inject -f - | \
 oc apply -n ${PROJECT_NAME} -f -

