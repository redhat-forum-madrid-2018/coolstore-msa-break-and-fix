#!/bin/bash

export PROJECT_NAME="coolstore"

oc new-project ${PROJECT_NAME}

oc adm policy add-scc-to-user privileged -z default -n ${PROJECT_NAME}
## Next apparently not necessary because we're using the anyuid addon
#oc adm policy add-scc-to-user anyuid -z default -n ${PROJECT_NAME}