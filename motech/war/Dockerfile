FROM motech/java:oracle-jdk8-jdk7

RUN apt-get update
RUN apt-get --yes install curl wget maven git

# Install Tomcat7
RUN cd /opt ; wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.65/bin/apache-tomcat-7.0.65.tar.gz
RUN cd /opt && tar xvzf apache-tomcat-7.0.65.tar.gz
ADD tomcat7/conf/tomcat-users.xml /opt/apache-tomcat-7.0.65/conf/tomcat-users.xml
RUN printf "export CATALINA_HOME=/opt/tomcat7\n" >> ~/.bashrc
RUN ln -s /opt/apache-tomcat-7.0.65 /opt/tomcat7

EXPOSE 8080
EXPOSE 8000

RUN rm -rf /opt/tomcat7/webapps/motech-platform-server.war /root/.motech/bundles

ADD ./root/motech/config/bootstrap.properties /root/.motech/config/bootstrap.properties
ADD ./root/motech/config/motech-settings.properties /root/.motech/config/motech-settings.properties

ADD ./root/run.sh /root/run.sh
RUN chmod a+x /root/run.sh

# Need to start tomcat
CMD ["/root/run.sh"]
