# Coolstore Microservices - Break & Fix

**TODO** Add description, objetives and goals.

# Architecture Diagram

**TODO** Add diagram and Microservices topology

# Prepare your OpenShift Cluster

**TODO** Add information about OpenShift and how to use it.
**TODO** Instructions to deploy into a local CDK (Minishift) instance

Create a new project:

```
$ oc new-project coolstore
$ oc project coolstore
```

# Microservices

## Catalog - Microservice with Spring Boot

**TODO** Add description and main Spring Boot features

To deploy into OpenShift:

```
$ cd catalog-spring-boot
$ mvn clean package fabric8:deploy
```

Testing API:

```
$ curl http://catalog-coolstore.$(minishift ip).nip.io/api/catalog | jq
[
  {
    "itemId": "329299",
    "name": "Red Fedora",
    "description": "Official Red Hat Fedora",
    "price": 34.99
  },
  ...
]
```

## Inventory - Enterprise Microservice with Wildfly Swarm

**TODO** Add description and main Wildfly features

To deploy into OpenShift:

```
$ cd inventory-wildfly-swarm
$ mvn clean package fabric8:deploy
```

Testing API:

```
$ curl http://inventory-coolstore.$(minishift ip).nip.io/api/inventory/329299 | jq
{
  "itemId": "329299",
  "quantity": 35
}
```

## Gateway - Reactive Microservice with Vert.x

**TODO** Add description and main Vert.x features

Prepare your namespace:

```
oc policy add-role-to-user view -z default -n coolstore
```

To deploy into OpenShift:

```
$ cd gateway-vertx
$ mvn clean package fabric8:deploy
```

Testing API:

```
$ curl http://gateway-coolstore.$(minishift ip).nip.io/api/products | jq
[
  {
    "itemId": "329299",
    "name": "Red Fedora",
    "description": "Official Red Hat Fedora",
    "price": 34.99,
    "availability": {
      "quantity": 35
    }
  },
  ...
]
```

Hystrix Dashboard lets you easily monitor the health of your services in real time by aggregating Hystrix metrics 
data from an event stream and displaying them on one screen.

```
$ oc create -f https://raw.githubusercontent.com/snowdrop/openshift-templates/master/hystrix-dashboard/hystrix-dashboard.yml
template "hystrix-dashboard" created
$ oc new-app --template=hystrix-dashboard
```

To access to the dashboard:

http://hystrix-dashboard-coolstore.$(minishift ip).nip.io/

http://gateway:8080/hystrix.stream

## Web Site - Rich User Experience with Node.js and AngularJS

**TODO** Add description and main Node.js and AngularJS features

To deploy in OpenShift:

```
$ cd web-nodejs
$ oc new-build --name web-ui --docker-image registry.access.redhat.com/rhscl/nodejs-8-rhel7:latest .
$ oc start-build web-ui --from-dir . --follow
$ oc new-app web-ui
$ oc expose svc/web-ui
```

Testing from a Web Browser [http://web-ui-coolstore.$(minishift ip).nip.io](http://web-ui-coolstore.$(minishift ip).nip.io/)

![](images/rh-coolstore-msa-app.png?raw=true)

# Main References

This repository is based in other cool repositories as:

* [Cloud Native Worshop](https://github.com/openshift-labs/cloud-native-guides/tree/ocp-3.10)
* [Cloud Native Roadshows Labs](https://github.com/openshift-labs/cloud-native-labs/tree/ocp-3.10)

* [Red Hat Cool Store Microservice Demo - Full version](https://github.com/jbossdemocentral/coolstore-microservice/tree/stable-ocp-3.10)

* [Red Hat Container Development Kit](https://access.redhat.com/documentation/en-us/red_hat_container_development_kit/)
