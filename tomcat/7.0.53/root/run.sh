#!/bin/bash

#
# create destination directories
#
mkdir -p /root/.motech/config/org.motechproject.metrics /root/.motech/bundles

#
# create bootstrap.properties
#
echo 'config.source=FILE
couchDb.url=http://'$COUCHDB_1_PORT_5984_TCP_ADDR':'$COUCHDB_1_PORT_5984_TCP_PORT'/
tenant.id=tomcat7
sql.url=jdbc:'$DB_TYPE'://'$DB_1_PORT_3306_TCP_ADDR':'$DB_1_PORT_3306_TCP_PORT'/
sql.user='$DB_USER'
sql.password='$DB_PASSWORD'
' > /root/.motech/config/bootstrap.properties

#
# create motech-settings.properties
#
echo 'system.language=en
statusmsg.timeout=60

provider.name=
provider.url=
login.mode=repository

jms.queue.for.events=QueueForEvents
jms.queue.for.scheduler=QueueForScheduler
jms.broker.url=tcp://'$ACTIVEMQ_1_PORT_61616_TCP_ADDR':'$ACTIVEMQ_1_PORT_61616_TCP_PORT'
jms.maximumRedeliveries=0
jms.redeliveryDelayInMillis=2000
jms.concurrentConsumers=1
jms.maxConcurrentConsumers=10
jms.session.cache.size=10
jms.cache.producers=false
' > /root/.motech/config/motech-settings.properties

#
# create statsdAgent.properties
#
echo 'serverHost='$STATSD_1_PORT_80_TCP_ADDR'
generateHostBasedStats=true
graphiteUrl=http://'$STATSD_1_PORT_80_TCP_ADDR'
serverPort='$STATSD_1_PORT_8125_UDP_PORT > /root/.motech/config/org.motechproject.metrics/statsdAgent.properties

#
# make MOTECH bundles & config dirs rw to host user so they can copy binaries & tweak config
#
chmod -R a+rw /root/.motech/bundles
chmod -R a+rw /root/.motech/config

#
# start tomcat in debug mode (jpda)
#
/opt/tomcat7/bin/catalina.sh jpda start
tail -f /opt/tomcat7/logs/catalina.out
