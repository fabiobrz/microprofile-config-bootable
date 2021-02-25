# microprofile-config-bootable

## Build a traditional WAR 
```
mvn clean install -DskipTests=true
```

... then deploy it on a running WildFly instance
```
<JBOSS_HOME>/bin/standalone.sh -c standalone-microprofile.xml
...
<JBOSS_HOME>/bin/jboss-cli.sh
You are disconnected at the moment. Type 'connect' to connect to the server or 'help' for the list of supported commands.
[disconnected /] connect
deploy target/microprofile-config.war
```

... and verify
```text
curl http://localhost:8080/microprofile-config/config/json
{"result":"Hello jim"}
```
Don't forget to stop your server. 

## Build the full bootable JAR

```
mvn clean package -Pfull-bootable -DskipTests=true
```

... run it:
```text
NAME=bob mvn wildfly-jar:run -Pfull-bootable
```

... and verify:
```text
curl http://localhost:8080/config/json
{"result":"Hello bob"}
```

(yep, different context root, I didn't have the time to tweak it...)

## Build the hollow bootable JAR
```
mvn clean package -Phollow-bootable
```
You'll see that tests are run. How? The same application sources are packaged as a Shrinkwrap archive and deployed to 
the hollow bootable JAR container by Arquillian

### Known issues
The `run-on-ocp.sh` script is doing what needed to package a Bootable JAR for OCP, deploying it, exposing it as a 
service and finally call the service URL. This last step is FAILING ATM (I need to check why).  

