#!/bin/sh

# Status Catalog Service
# http://catalog-coolstore.$(minishift ip).nip.io/api/break/status
# Status Inventory Service
# http://inventory-coolstore.$(minishift ip).nip.io/api/break/status

# OCP Environment
# OCP_BASE_URL="coolstore.$(minishift ip).nip.io"
OCP_BASE_URL=${1:-"coolstore.127.0.0.1.nip.io"}

# Service and Fix Type
SERVICE_LIST=("catalog" "inventory")

for i_service in {0..1}; do
  service=${SERVICE_LIST[$i_service]}
  echo "Status '$service' service"

    ocp_status_url="http://$service-$OCP_BASE_URL/api/break/status"
    # echo "OCP Status Url: $ocp_status_url"

    # Invoking service
    HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}\n" $ocp_status_url)
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
