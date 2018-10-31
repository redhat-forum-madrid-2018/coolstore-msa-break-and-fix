#!/bin/bash

export PROJECT_NAME="coolstore"

export ISTIO_VERSION=1.0.2
export ISTIO_PROJECT_NAME="istio-system"
export OS="linux" # osx | linux

export MINISHIFT_PROFILE="rh-forum-2018"
export MINISHIFT_MEMORY="12GB"
export MINISHIFT_CPUS="3"
export MINISHIFT_VM_DRIVER="kvm" # xhyve | virtualbox | kvm
export MINISHIFT_DISK_SIZE="50g"

export JAEGER_URL="https:\/\/jaeger-query-${ISTIO_PROJECT_NAME}.apps.istio.openshiftworkshop.com"
export GRAFANA_URL="http:\/\/grafana-${ISTIO_PROJECT_NAME}.apps.istio.openshiftworkshop.com"
export VERSION_LABEL="v0.9.0"
export IMAGE_NAME="kiali\/kiali"
export VERBOSE_MODE=4
export IMAGE_PULL_POLICY_TOKEN="imagePullPolicy: Always"

