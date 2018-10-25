#!/bin/sh

# Breaking - Catalog Service
# Breaking - Catalog - Sleeping
# http://catalog-coolstore.$(minishift ip).nip.io/api/break/sleep/4000
# Breaking - Catalog - Exception
# http://catalog-coolstore.$(minishift ip).nip.io/api/break/exception/Opps.%20Something%20was%20wrong
# Breaking - Catalog - Disabled
# http://catalog-coolstore.$(minishift ip).nip.io/api/break/disabled

# Breaking - Inventory Service
# Breaking - Inventory - Sleeping
# http://inventory-coolstore.$(minishift ip).nip.io/api/break/sleep/4000
# Breaking - Inventory - Exception
# http://inventory-coolstore.$(minishift ip).nip.io/api/break/exception/Opps.%20Something%20was%20wrong
# Breaking - Inventory - Disabled
# http://inventory-coolstore.$(minishift ip).nip.io/api/break/disabled

# TODO Define as arguments of this service
# OCP Environment
# OCP_BASE_URL="coolstore.$(minishift ip).nip.io"
OCP_BASE_URL=${1:-"coolstore.127.0.0.1.nip.io"}
TIMEOUT=${2:-4000}
EXCEPTION_MSG=${3:-"Opps.%20Please,%20Redeploy%20me!!!"}

# Service and Break Type
SERVICE_LIST=("catalog" "inventory")
BREAK_TYPE_LIST=("sleep/$TIMEOUT" "exception/$EXCEPTION_MSG" "disabled")

# Seed Random generator
RANDOM=$$$(date +%s)

# Generating Break Url
service=${SERVICE_LIST[$RANDOM % ${#SERVICE_LIST[@]}]}
break_type=${BREAK_TYPE_LIST[$RANDOM % ${#BREAK_TYPE_LIST[@]}]}
ocp_break_url="http://$service-$OCP_BASE_URL/api/break/$break_type"

echo "Breaking '$service' with '$break_type'"
echo "OCP Break Url: $ocp_break_url"

# Invoking service
HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}\n" $ocp_break_url)
# extract the body
HTTP_BODY=$(echo $HTTP_RESPONSE | sed -e 's/HTTPSTATUS\:.*//g')
# extract the status
HTTP_STATUS=$(echo $HTTP_RESPONSE | tr -d '\n' | sed -e 's/.*HTTPSTATUS://')

if [[ $HTTP_STATUS = "200" ]] ; then
  echo "$HTTP_BODY"
else
  echo "Something was wrong to break the service ($HTTP_STATUS). Review deployment"
  # oc rollout latest "dc/$service"
fi

# TODO Start timer (crono)
# TODO Define a success method
# TODO Stop timer and generate report
