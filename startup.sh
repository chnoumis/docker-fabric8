#!/bin/sh

ADMIN_USERNAME=${ADMIN_USERNAME:-admin}
ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}

echo Welcome to fabric8: http://fabric8.io/
echo
echo Starting Fabric8 container ID: $FABRIC8_RUNTIME_ID
echo Using admin user:              ${ADMIN_USERNAME}
echo Docker REST API:               ${DOCKER_HOST}
echo Connecting to ZooKeeper:       $FABRIC8_ZOOKEEPER_URL 
echo Environment:                   $FABRIC8_FABRIC_ENVIRONMENT
echo Using bindaddress:             $FABRIC8_BINDADDRESS

echo "${ADMIN_USERNAME}=${ADMIN_PASSWORD},admin,manager,viewer" > /opt/fabric8/etc/users.properties

cp -rf /opt/fabric8/build/bin /opt/fabric8/

if [ $FABRIC8_ECLIPSELINK_MOXY = "true" ]; then
	cp -rf /opt/fabric8/build/system /opt/fabric8/
fi

# Use exec to replace shell with process to ensure signals get handled correctly
if [ $FABRIC8_FABRIC = "true" ]; then
	exec /opt/fabric8/bin/fabric8 server
else
	exec /opt/fabric8/bin/karaf server
fi	