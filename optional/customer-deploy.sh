#!/bin/bash

# Environment
. ./0-environment.sh

export PROJECT_NAME="customer"

oc new-project ${PROJECT_NAME}

oc adm policy add-scc-to-user privileged -z default -n ${PROJECT_NAME}
## Next apparently not necessary because we're using the anyuid addon
#oc adm policy add-scc-to-user anyuid -z default -n ${PROJECT_NAME}

#### deploy customer

oc new-app -n ${PROJECT_NAME} --name=customer --context-dir=customer/java/springboot -e JAEGER_SERVICE_NAME=customer JAEGER_ENDPOINT=http://jaeger-collector.${ISTIO_PROJECT_NAME}.svc:14268/api/traces JAEGER_PROPAGATION=b3 JAEGER_SAMPLER_TYPE=const JAEGER_SAMPLER_PARAM=1 JAVA_OPTIONS='-Xms128m -Xmx256m -Djava.net.preferIPv4Stack=true' fabric8/s2i-java~https://github.com/redhat-developer-demos/istio-tutorial -o yaml  > customer.yml
oc apply -f <(istioctl kube-inject -f customer.yml) -n ${PROJECT_NAME}
oc delete -n ${PROJECT_NAME} svc/customer

cat << EOF | oc create -n ${PROJECT_NAME} -f -
apiVersion: v1
kind: Service
metadata:
  name: customer
  labels:
    app: customer    
spec:
  ports:
  - name: http
    port: 8080
  selector:
    app: customer
EOF

sleep 5

oc logs bc/customer -f -n ${PROJECT_NAME}

oc expose service customer -n ${PROJECT_NAME}

#### deploy preference

oc new-app -n ${PROJECT_NAME} -l app=preference,version=v1 --name=preference-v1 --context-dir=preference/java/springboot -e JAEGER_SERVICE_NAME=preference JAEGER_ENDPOINT=http://jaeger-collector.${ISTIO_PROJECT_NAME}.svc:14268/api/traces JAEGER_PROPAGATION=b3 JAEGER_SAMPLER_TYPE=const JAEGER_SAMPLER_PARAM=1 JAVA_OPTIONS='-Xms128m -Xmx256m -Djava.net.preferIPv4Stack=true' fabric8/s2i-java~https://github.com/redhat-developer-demos/istio-tutorial -o yaml  > preference.yml
oc apply -f <(istioctl kube-inject -f preference.yml) -n ${PROJECT_NAME}
oc delete svc/preference-v1

cat << EOF | oc create -n ${PROJECT_NAME} -f -
apiVersion: v1
kind: Service
metadata:
  name: preference
  labels:
    app: preference    
spec:
  ports:
  - name: http
    port: 8080
  selector:
    app: preference
EOF

sleep 5

oc logs bc/preference-v1 -f

### deploy recommendation

oc new-app -n ${PROJECT_NAME} -l app=recommendation,version=v1 --name=recommendation-v1 --context-dir=recommendation/java/vertx JAVA_OPTIONS='-Xms128m -Xmx256m -Djava.net.preferIPv4Stack=true' fabric8/s2i-java~https://github.com/redhat-developer-demos/istio-tutorial -o yaml  > recommendation.yml
oc apply -f <(istioctl kube-inject -f recommendation.yml) -n ${PROJECT_NAME}
oc delete svc/recommendation-v1

cat << EOF | oc create -n ${PROJECT_NAME} -f -
apiVersion: v1
kind: Service
metadata:
  name: recommendation
  labels:
    app: recommendation    
spec:
  ports:
  - name: http
    port: 8080
  selector:
    app: recommendation
EOF

sleep 5

oc logs bc/recommendation-v1 -f

#### Status
oc get route -n ${PROJECT_NAME}
oc get pods -n ${PROJECT_NAME} -w