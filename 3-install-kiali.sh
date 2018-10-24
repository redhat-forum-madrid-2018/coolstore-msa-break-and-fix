JAEGER_URL="https:\/\/jaeger-query-istio-system.apps.istio.openshiftworkshop.com"
GRAFANA_URL="http:\/\/grafana-istio-system.apps.istio.openshiftworkshop.com"
VERSION_LABEL="v0.7.2"
IMAGE_NAME="kiali\/kiali"
NAMESPACE=istio-system
VERBOSE_MODE=4
IMAGE_PULL_POLICY_TOKEN="imagePullPolicy: Always" 

curl https://raw.githubusercontent.com/kiali/kiali/${VERSION_LABEL}/deploy/openshift/kiali-configmap.yaml | \
  sed -e "s/\${VERSION_LABEL}/${VERSION_LABEL}/" -e "s/\${JAEGER_URL}/${JAEGER_URL}/" -e "s/\${GRAFANA_URL}/${GRAFANA_URL}/"  | \
  oc create -n istio-system -f -

curl https://raw.githubusercontent.com/kiali/kiali/${VERSION_LABEL}/deploy/openshift/kiali-secrets.yaml | \
  sed -e "s/\${VERSION_LABEL}/${VERSION_LABEL}/"  | oc create -n istio-system -f -

curl https://raw.githubusercontent.com/kiali/kiali/${VERSION_LABEL}/deploy/openshift/kiali.yaml | \
  sed -e "s/\${VERSION_LABEL}/${VERSION_LABEL}/"  | \
  sed -e "s/\${IMAGE_NAME}/${IMAGE_NAME}/" | \
  sed -e "s/\${IMAGE_VERSION}/${VERSION_LABEL}/" | \
  sed -e "s/\${NAMESPACE}/${NAMESPACE}/" | \
  sed -e "s/\${VERBOSE_MODE}/${VERBOSE_MODE}/" | \
  sed -e "s/\${IMAGE_PULL_POLICY_TOKEN}/${IMAGE_PULL_POLICY_TOKEN}/" | \
  oc create -n istio-system -f -