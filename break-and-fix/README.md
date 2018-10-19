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


# Running

oc run web-load --restart='OnFailure' --image=siamaksade/siege -- -c4 -d2 -t5M -v http://web-ui:8080/

-c: concurrent users
-d: delay
-t: time 

oc run siege-load-web-ui --restart='OnFailure' --image=siamaksade/siege -- -c4 -d2 -t10M http://web-ui:8080

oc run siege-load-gateway --restart='OnFailure' --image=siamaksade/siege -- -c4 -d2 -t10M -v http://gateway:8080/api/products


add scripts to manipulate locally pods when the broker is not available
