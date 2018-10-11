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
