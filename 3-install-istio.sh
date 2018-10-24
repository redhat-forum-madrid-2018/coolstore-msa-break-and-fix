#!/bin/bash

# Environment
ISTIO_VERSION=1.0.2
OS="osx" # osx | linux

# Login
eval $(minishift oc-env)
eval $(minishift docker-env)
oc login $(minishift ip):8443 -u admin -p admin

# Download istio
curl -L https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-${OS}.tar.gz | tar xz

cd istio-${ISTIO_VERSION}
export ISTIO_HOME=`pwd`
export PATH=$ISTIO_HOME/bin:$PATH

kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml

kubectl apply -f install/kubernetes/istio-demo.yaml

kubectl config set-context $(kubectl config current-context) --namespace=istio-system

oc expose svc istio-ingressgateway
oc expose svc servicegraph
oc expose svc grafana
oc expose svc prometheus
oc expose svc tracing
