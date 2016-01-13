#!/bin/bash

# Set config with the appropiate host:port of the linked containers
sed -e 's/MQ_HOST/'$ACTIVEMQ_1_PORT_61616_TCP_ADDR'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/MQ_PORT/'$ACTIVEMQ_1_PORT_61616_TCP_PORT'/' -i /root/.motech/config/bootstrap.properties

sed -e 's/DB_TYPE/'$DB_TYPE'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_HOST/'$DB_1_PORT_3306_TCP_ADDR'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_PORT/'$DB_1_PORT_3306_TCP_PORT'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_USER/'$DB_USER'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_PASSWORD/'$DB_PASSWORD'/' -i /root/.motech/config/bootstrap.properties
sed -e 's/DB_DRIVER/'$DB_DRIVER'/' -i /root/.motech/config/bootstrap.properties

/opt/tomcat7/bin/catalina.sh run
