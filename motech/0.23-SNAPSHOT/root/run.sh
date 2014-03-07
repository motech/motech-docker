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

sed -e 's/STATSD_PORT/'$STATSD_1_PORT_8125_UDP_PORT'/' -i /root/.motech/config/org.motechproject.metrics/statsdAgent.properties
sed -e 's/STATSD_HOST/'$STATSD_1_PORT_80_TCP_ADDR'/' -i /root/.motech/config/org.motechproject.metrics/statsdAgent.properties

# Add the admin user to the database
sleep 15s
echo "****************************************************************************************"
echo "****************************************************************************************"
echo "****************************************************************************************"
echo "****************************************************************************************"
echo "****************************************************************************************"
curl -X PUT "http://${COUCHDB_1_PORT_5984_TCP_ADDR}:${COUCHDB_1_PORT_5984_TCP_PORT}/${USER}_motech-web-security"
curl -X POST "http://${COUCHDB_1_PORT_5984_TCP_ADDR}:${COUCHDB_1_PORT_5984_TCP_PORT}/${USER}_motech-web-security" -d @/root/admin-user.json -H 'Content-Type: application/json'
echo "****************************************************************************************"
echo "****************************************************************************************"
echo "****************************************************************************************"
echo "****************************************************************************************"
echo "****************************************************************************************"

/opt/tomcat7/bin/catalina.sh run