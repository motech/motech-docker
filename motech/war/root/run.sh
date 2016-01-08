#!/bin/bash

# Set config with the appropiate host:port of the linked containers
sed -e 's/COUCH_HOST/'$COUCHDB_1_PORT_5984_TCP_ADDR'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/COUCH_PORT/'$COUCHDB_1_PORT_5984_TCP_PORT'/' -i /root/.motech/config/bootstrap.properties

sed -e 's/MQ_HOST/'$ACTIVEMQ_1_PORT_61616_TCP_ADDR'/' -i /root/.motech/config/motech-settings.properties
sed -e 's/MQ_PORT/'$ACTIVEMQ_1_PORT_61616_TCP_PORT'/' -i /root/.motech/config/motech-settings.properties

sed -e 's/DB_TYPE/'$DB_TYPE'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_HOST/'$DB_1_PORT_3306_TCP_ADDR'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_PORT/'$DB_1_PORT_3306_TCP_PORT'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_USER/'$DB_USER'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_PASSWORD/'$DB_PASSWORD'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_DRIVER/'$DB_DRIVER'/' -i /root/.motech/config/bootstrap.properties

if [[ "$MOTECH_VERSION" == *-SNAPSHOT ]]
then
	REPO="snapshots"
else
	REPO="releases"
fi

# Pre 1.0 versions use java 7, not 8
if [[ "$MOTECH_VERSION" == 0* ]]
then
	update-java-alternatives -s java-7-oracle
	echo "Preparing MOTECH ${MOTECH_VERSION}. Using JAVA 7."
else
	update-java-alternatives -s java-8-oracle
	echo "Preparing MOTECH ${MOTECH_VERSION}. Using JAVA 8."
fi

curl -L "http://nexus.motechproject.org/service/local/artifact/maven/redirect?r=${REPO}&g=org.motechproject&a=motech-platform-server&p=war&v=${MOTECH_VERSION}" -o /opt/tomcat7/webapps/motech-platform-server.war

/opt/tomcat7/bin/catalina.sh run
