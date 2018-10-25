#!/bin/sh

oc delete pod siege-load-gateway --force
oc delete pod siege-load-catalog --force
oc delete pod siege-load-inventory --force
sleep 10

oc run siege-load-gateway -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- -c4 -d2 -t10M -v http://gateway-coolstore.$(minishift ip).nip.io/api/products

oc run siege-load-catalog -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- -c4 -d2 -t10M -v http://catalog-coolstore.$(minishift ip).nip.io/api/catalog

oc run siege-load-inventory -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- -c4 -d2 -t10M -v http://inventory-coolstore.$(minishift ip).nip.io/api/inventory/329299
