#!/bin/bash

export PROJECT_NAME="coolstore"

export ISTIO_VERSION=1.0.2
export OS="osx" # osx | linux

export JAEGER_URL="https:\/\/jaeger-query-istio-system.apps.istio.openshiftworkshop.com"
export GRAFANA_URL="http:\/\/grafana-istio-system.apps.istio.openshiftworkshop.com"
export VERSION_LABEL="v0.7.2"
export IMAGE_NAME="kiali\/kiali"
export NAMESPACE=istio-system
export VERBOSE_MODE=4
export IMAGE_PULL_POLICY_TOKEN="imagePullPolicy: Always" 
