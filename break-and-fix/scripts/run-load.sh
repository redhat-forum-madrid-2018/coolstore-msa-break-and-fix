#!/bin/sh

oc delete pod siege-load-gateway-ingress -n coolstore --force
oc delete pod siege-load-gateway -n coolstore --force
oc delete pod siege-load-catalog -n coolstore --force
oc delete pod siege-load-inventory -n coolstore --force
oc delete pod siege-load-web-ui -n coolstore --force

sleep 10

# Siege Configuration
# Info: https://www.joedog.org/siege-manual/
CONCURRENT_USERS="-c2"
# Random delay of seconds between requests
DELAY="-d10"
# Period of time to run the test
TIME="-t60M"

oc run siege-load-gateway-ingress -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- $CONCURRENT_USERS $DELAY $TIME -v http://istio-ingressgateway-istio-system.$(minishift ip).nip.io/api/products

oc run siege-load-gateway -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- $CONCURRENT_USERS $DELAY $TIME -v http://gateway-coolstore.$(minishift ip).nip.io/api/products

oc run siege-load-catalog -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- $CONCURRENT_USERS $DELAY $TIME -v http://catalog-coolstore.$(minishift ip).nip.io/api/catalog

oc run siege-load-inventory -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- $CONCURRENT_USERS $DELAY $TIME -v http://inventory-coolstore.$(minishift ip).nip.io/api/inventory/329299

oc run siege-load-web-ui -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- $CONCURRENT_USERS $DELAY $TIME -v http://web-ui-coolstore.$(minishift ip).nip.io/

