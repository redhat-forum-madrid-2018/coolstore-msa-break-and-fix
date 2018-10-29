#!/bin/sh

# Fixing Catalog Service
# Fixing - Catalog - Sleep
# http://catalog-coolstore.$(minishift ip).nip.io/api/fix/sleep
# Fixing - Catalog - Exception
# http://catalog-coolstore.$(minishift ip).nip.io/api/fix/exception

# Fixing Inventory Service
# Fixing - Inventory - Sleep
# http://inventory-coolstore.$(minishift ip).nip.io/api/fix/sleep
# Fixing - Inventory - Exception
# http://inventory-coolstore.$(minishift ip).nip.io/api/fix/exception

# OCP Environment
OCP_BASE_URL=${1:-"coolstore.$(minishift ip).nip.io"}

# Service and Fix Type
SERVICE_LIST=("catalog" "inventory")
FIX_TYPE_LIST=("sleep" "exception")

for i_service in {0..1}; do
  SERVICE=${SERVICE_LIST[$i_service]}
  echo "Fixing '$SERVICE'"

  for i_fix in {0..1}; do
    FIX_TYPE=${FIX_TYPE_LIST[$i_fix]}

    OCP_FIX_URL="http://$SERVICE-$OCP_BASE_URL/api/fix/$FIX_TYPE"

    # Invoking service
    HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}\n" $OCP_FIX_URL)
    # extract the body
    HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')
    # extract the status
    HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

    if [[ $HTTP_STATUS = "200" ]] ; then
      echo "Service fixed"
    else
      echo "Something was wrong to fix the service ($fixResponse). Rolling deployment"
      # oc rollout latest "dc/$service"
    fi
  done
done
