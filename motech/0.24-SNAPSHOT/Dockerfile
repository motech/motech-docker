FROM motech/java:oracle-jdk7

RUN apt-get --yes install curl wget maven git

# Install Tomcat7
RUN cd /opt ; wget http://apache.cs.utah.edu/tomcat/tomcat-7/v7.0.52/bin/apache-tomcat-7.0.52.tar.gz
RUN cd /opt && tar xvzf apache-tomcat-7.0.52.tar.gz
ADD tomcat7/conf/tomcat-users.xml /opt/apache-tomcat-7.0.52/conf/tomcat-users.xml
RUN printf "export CATALINA_HOME=/opt/tomcat7\n" >> ~/.bashrc
RUN ln -s /opt/apache-tomcat-7.0.52 /opt/tomcat7

EXPOSE 8080
EXPOSE 8000

# # Checkout and compile motech
# RUN cd /opt && git clone https://code.google.com/p/motech

# # This one file is UTF-8 so convert it to ascii
# RUN iconv -c -f UTF-8 -t ISO-8859-1 /opt/motech/platform/server-bundle/src/main/resources/webapp/lib/jquery/jquery.blockUI.js > /tmp/jquery.blockUI.js
# RUN mv /tmp/jquery.blockUI.js /opt/motech/platform/server-bundle/src/main/resources/webapp/lib/jquery/jquery.blockUI.js

# #RUN printf "export MAVEN_OPTS=\"-Xmx512m -XX:MaxPermSize=128m\"\n" >> ~/.profile
# RUN cd /opt/motech && env MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=128m" mvn clean install

# # Checkout and compile Platform-*
# RUN cd /opt && git clone https://github.com/motech/platform-campaigns
# RUN cd /opt/platform-campaigns && mvn clean install

# RUN cd /opt && git clone https://github.com/motech/platform-medical-records
# RUN cd /opt/platform-medical-records && mvn clean install

# RUN cd /opt && git clone https://github.com/motech/platform-communications
# RUN cd /opt/platform-communications && mvn clean install

# # move platform server war to tomcat dir
# RUN cp /opt/motech/platform/server/target/motech-platform-server.war /opt/tomcat7/webapps/

# FROM motech/motech:0.23-SNAPSHOT

RUN rm -rf /opt/tomcat7/webapps/motech-platform-server.war /root/.motech/bundles

ADD ./root/motech/bundles /root/.motech/bundles
ADD ./opt/tomcat7/webapps/motech-platform-server.war /tmp/motech-platform-server.war
RUN mv /tmp/motech-platform-server.war /opt/tomcat7/webapps/motech-platform-server.war

ADD ./root/motech/config/bootstrap.properties /root/.motech/config/bootstrap.properties
ADD ./root/motech/config/motech-settings.properties /root/.motech/config/motech-settings.properties

ADD ./root/run.sh /root/run.sh
RUN chmod a+x /root/run.sh

# Need to start tomcat
CMD ["/root/run.sh"]
