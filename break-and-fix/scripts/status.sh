#!/bin/sh

# Status Catalog Service
# http://catalog-coolstore.$(minishift ip).nip.io/api/break/status
# Status Inventory Service
# http://inventory-coolstore.$(minishift ip).nip.io/api/break/status

# OCP Environment
OCP_BASE_URL=${1:-"coolstore.$(minishift ip).nip.io"}

# Service and Fix Type
SERVICE_LIST=("catalog" "inventory")

for i_service in {0..1}; do
  SERVICE=${SERVICE_LIST[$i_service]}
  echo "Status '$service' service"

    OCP_STATUS_URL="http://$SERVICE-$OCP_BASE_URL/api/break/status"

    # Invoking service
    HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}\n" $OCP_STATUS_URL)
    # extract the body
    HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')
    # extract the status
    HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

    if [[ $HTTP_STATUS = "200" ]] ; then
      echo "$HTTP_BODY"
    else
      echo "Something was wrong to get the status ($HTTP_STATUS). Review deployment"
      # oc rollout latest "dc/$service"
    fi
done
