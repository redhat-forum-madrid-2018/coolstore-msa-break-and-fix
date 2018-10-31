#!/bin/bash

# Environment
. ./0-environment.sh

oc new-project dashboard
oc process -f break-and-fix/openshift/break-and-fix-dashboard-template.yaml | oc create -n dashboard -f -

