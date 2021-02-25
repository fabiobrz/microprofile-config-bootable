#!/bin/bash

mvn package -Pfull-bootable-openshift -DskipTests=true

mkdir target/openshift && cp target/microprofile-config-bootable.jar target/openshift
# Import the OpenJDK 11 image to run the Java application
oc import-image ubi8/openjdk-11 --from=registry.redhat.io/ubi8/openjdk-11 --confirm
oc new-build --strategy source --binary --image-stream openjdk-11 --name microprofile-config-app
oc start-build microprofile-config-app --from-dir target/openshift

# Once the application image has been built, it will be available with the imagestream tag microprofile-config-app:latest:
sleep 60
oc get is microprofile-config-app

# Deploy the application
oc new-app microprofile-config-app -e CONFIG1="Value comes from the env"
oc expose svc/microprofile-config-app
curl http://$(oc get route microprofile-config-app --template='{{ .spec.host }}')

