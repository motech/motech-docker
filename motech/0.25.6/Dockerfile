FROM motech/java:oracle-jdk7

RUN apt-get --yes install curl wget maven git

# Install Tomcat7
RUN cd /opt ; wget http://www.us.apache.org/dist/tomcat/tomcat-7/v7.0.65/bin/apache-tomcat-7.0.65.tar.gz
RUN cd /opt && tar xvzf apache-tomcat-7.0.65.tar.gz
ADD tomcat7/conf/tomcat-users.xml /opt/apache-tomcat-7.0.65/conf/tomcat-users.xml
RUN printf "export CATALINA_HOME=/opt/tomcat7\n" >> ~/.bashrc
RUN ln -s /opt/apache-tomcat-7.0.65 /opt/tomcat7

EXPOSE 8080
EXPOSE 8000

RUN rm -rf /opt/tomcat7/webapps/motech-platform-server.war /root/.motech/bundles
RUN wget http://nexus.motechproject.org/service/local/repositories/releases/content/org/motechproject/motech-platform-server/0.25.6/motech-platform-server-0.25.6.war -O /opt/tomcat7/webapps/motech-platform-server.war

ADD ./root/motech/config/bootstrap.properties /root/.motech/config/bootstrap.properties
ADD ./root/motech/config/motech-settings.properties /root/.motech/config/motech-settings.properties

ADD ./root/run.sh /root/run.sh
RUN chmod a+x /root/run.sh

# Need to start tomcat
CMD ["/root/run.sh"]
