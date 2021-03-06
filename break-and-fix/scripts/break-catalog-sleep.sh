#!/bin/sh

# Breaking - Catalog Service
# Breaking - Catalog - Sleeping
# http://catalog-coolstore.$(minishift ip).nip.io/api/break/sleep/4000

# OCP Environment
OCP_BASE_URL=${1:-"coolstore.$(minishift ip).nip.io"}
TIMEOUT=${2:-4000}

# Service and Break Type
SERVICE="catalog"
BREAK_TYPE="sleep/$TIMEOUT"

# Generating Break Url
OCP_BREAK_URL="http://$SERVICE-$OCP_BASE_URL/api/break/$BREAK_TYPE"

echo "Breaking '$SERVICE' with '$BREAK_TYPE'"
echo "OCP Break Url: $OCP_BREAK_URL"

# Invoking service
HTTP_RESPONSE=$(curl --silent --write-out "HTTPSTATUS:%{http_code}\n" $OCP_BREAK_URL)
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
