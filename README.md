# microprofile-config-bootable

## Build a traditional WAR 
```
mvn clean install -DskipTests=true
```
... then deploy it on a running WildFly instance

## Build the full bootable JAR
```
mvn clean package -Pfull-bootable -DskipTests=true
```
... and run it:
```text
NAME=bob mvn wildfly-jar:run -Pfull-bootable
```

## Build the hollow bootable JAR
```
mvn clean package -Phollow-bootable
```
You'll see that tests are run. How? The same application sources are packaged as a Shrinkwrap archive and deployed to 
the hollow bootable JAR container by Arquillian

### Known issues
The `run-on-ocp.sh` script is doing what needed to package a Bootable JAR for OCP, deploying it, exposing it as a 
service and finally call the service URL. This last step is FAILING ATM (I need to check why).  

