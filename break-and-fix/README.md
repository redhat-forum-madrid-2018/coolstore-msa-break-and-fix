# Coolstore Microservices - Break & Fix

# Microservices

## Catalog - Microservice with Spring Boot

Getting status of the microservice:

```
$ curl http://catalog-coolstore.$(minishift ip).nip.io/api/break/status | jq
"DELAYED"
```

Available responses: "OK" | "BROKEN" | "DELAYED"

Breaking with a delay of 4 seconds:

```
$ curl http://catalog-coolstore.$(minishift ip).nip.io/api/break/sleep/4000 | jq
{
  "delay": 4000,
  "brokenMessage": null,
  "status": "DELAYED"
}
```

Fixing the delay:

```
$ curl http://catalog-coolstore.$(minishift ip).nip.io/api/fix/sleep | jq
{
  "delay": 0,
  "brokenMessage": null,
  "status": "OK"
}
```

Breaking with a exception:

```
$ curl http://catalog-coolstore.$(minishift ip).nip.io/api/break/exception/Opps.%20Something%20was%20wrong | jq
{
  "delay": 0,
  "brokenMessage": "Opps. Something was wrong",
  "status": "BROKEN"
}
```

Fixing the exception:

```
$ curl http://catalog-coolstore.$(minishift ip).nip.io/api/fix/exception | jq
{
  "delay": 0,
  "brokenMessage": null,
  "status": "OK"
}
```

Disabling the application:

```
$ curl http://catalog-coolstore.$(minishift ip).nip.io/api/break/disabled | jq
{
  "delay": 0,
  "brokenMessage": null,
  "status": "NOT_READY"
}
```

## Inventory - Enterprise Microservice with Wildfly Swarm

Getting status of the microservice:

```
$ curl http://inventory-coolstore.$(minishift ip).nip.io/api/break/status | jq
"DELAYED"
```

Available responses: "OK" | "BROKEN" | "DELAYED"

Breaking with a delay of 4 seconds:

```
$ curl http://inventory-coolstore.$(minishift ip).nip.io/api/break/sleep/4000 | jq
{
  "delay": 4000,
  "brokenMessage": null,
  "status": "DELAYED"
}
```

Fixing the delay:

```
$ curl http://inventory-coolstore.$(minishift ip).nip.io/api/fix/sleep | jq
{
  "delay": 0,
  "brokenMessage": null,
  "status": "OK"
}
```

Breaking with a exception:

```
$ curl http://inventory-coolstore.$(minishift ip).nip.io/api/break/exception/Opps.%20Something%20was%20wrong | jq
{
  "delay": 0,
  "brokenMessage": "Opps. Something was wrong",
  "status": "BROKEN"
}
```

Fixing the exception:

```
$ curl http://inventory-coolstore.$(minishift ip).nip.io/api/fix/exception | jq
{
  "delay": 0,
  "brokenMessage": null,
  "status": "OK"
}
```

Disabling the application:

```
$ curl http://inventory-coolstore.$(minishift ip).nip.io/api/break/disabled | jq
{
  "delay": 0,
  "brokenMessage": null,
  "status": "NOT_READY"
}
```

# Load Services

There is a script to execute some pods to load some request during some time. This file is located at [./scripts/run-load.sh](./scripts/run-load.sh).

Basically it is created some pods to execute some API endpoints as:

```
oc run siege-load-gateway -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- -c4 -d2 -t10M -v http://gateway-coolstore.$(minishift ip).nip.io/api/products

oc run siege-load-catalog -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- -c4 -d2 -t10M -v http://catalog-coolstore.$(minishift ip).nip.io/api/catalog

oc run siege-load-inventory -n coolstore --restart='OnFailure' --image=siamaksade/siege \
  -- -c4 -d2 -t10M -v http://inventory-coolstore.$(minishift ip).nip.io/api/inventory/329299
```

# Install Break and Fix Dashboard

Break and Fix Dashboard allows you to play with this repo:

1.- Describe the challenge
2.- Starting a challenge
3.- Review the hall of fame

To install it:

```
$ oc new-project dashboard
$ oc policy add-role-to-user view -z default -n dashboard
$ oc process -f openshift/break-and-fix-dashboard-template.yaml | oc create -f -
```
