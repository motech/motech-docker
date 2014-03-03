FROM ubuntu:12.04

RUN apt-get update

# Install Java
RUN apt-get install --yes python-software-properties
RUN add-apt-repository --yes ppa:webupd8team/java
RUN apt-get update

RUN apt-get --yes install curl

# Set some vars so the oracle installer doesn't ask us to accept the license
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get install --yes oracle-java7-installer

RUN apt-get --yes install maven git

# Install Tomcat7
RUN cd /opt ; wget http://apache.cs.utah.edu/tomcat/tomcat-7/v7.0.52/bin/apache-tomcat-7.0.52.tar.gz
RUN cd /opt && tar xvzf apache-tomcat-7.0.52.tar.gz
ADD tomcat7/conf/tomcat-users.xml /opt/apache-tomcat-7.0.52/conf/tomcat-users.xml
RUN printf "export CATALINA_HOME=/opt/tomcat7" >> ~/.bashrc
RUN ln -s /opt/apache-tomcat-7.0.52 /opt/tomcat7

EXPOSE 8080:8080
EXPOSE 8000:8000

# Checkout and compile motech
RUN cd /opt && git clone https://code.google.com/p/motech
RUN cd /opt/motech && mvn clean install

# Checkout and compile Platform-*
RUN cd /opt && git clone https://github.com/motech/platform-campaigns
RUN cd /opt/platform-campaigns && mvn clean install

RUN cd /opt && git clone https://github.com/motech/platform-medical-records
RUN cd /opt/platform-medical-records && mvn clean install

RUN cd /opt && git clone https://github.com/motech/platform-communications
RUN cd /opt/platform-communications && mvn clean install

# move platform server war to tomcat dir

# Need to start tomcat

# tail -f logfile