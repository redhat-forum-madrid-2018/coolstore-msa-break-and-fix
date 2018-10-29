#!/bin/bash

oc new-project dashboard
oc process -f openshift/break-and-fix-dashboard-template.yaml | oc create -n dashboard -f -
