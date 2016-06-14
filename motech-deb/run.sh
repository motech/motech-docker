#!/bin/bash

# Run activemq
ln -s /etc/activemq/instances-available/main /etc/activemq/instances-enabled/main
sed -e 's/<broker /<broker schedulerSupport="true" /' -i /etc/activemq/instances-enabled/main/activemq.xml
service activemq start

# Run mysql
service mysql start

# Start motech service
service motech start

# The container will run as long as the script is running, that's why
# we need something long-lived here
exec tail -f /usr/share/motech/logs/catalina.out


