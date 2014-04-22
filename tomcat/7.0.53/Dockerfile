FROM motech/java:oracle-jdk7

#
# Environment
#
ENV TOMCAT_VERSION 7.0.53

#
# Install Tomcat7
#
RUN cd /opt ; wget http://apache.cs.utah.edu/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN cd /opt && tar xvzf apache-tomcat-${TOMCAT_VERSION}.tar.gz
ADD tomcat7/conf/tomcat-users.xml /opt/apache-tomcat-${TOMCAT_VERSION}/conf/tomcat-users.xml
RUN printf "export CATALINA_HOME=/opt/tomcat7\n" >> ~/.bashrc
RUN ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat7

EXPOSE 8080
EXPOSE 8000

#
# Create MOTECH config files & start Tomcat in debug mode
#
ADD ./root/.motech /root/.motech
ADD ./root/run.sh /root/run.sh
RUN chmod a+x /root/run.sh
CMD ["/root/run.sh"]
