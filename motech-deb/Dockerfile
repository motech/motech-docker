FROM ubuntu:latest

RUN apt-get update

#Install Java 8
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
# Set some vars so the oracle installer doesn't ask us to accept the license
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java8-installer

#Install tomcat, activemq, mysql, curl
RUN apt-get install tomcat7 -y
RUN apt-get install -y activemq mysql-server curl

#Install motech DEB
ADD /motech-base.deb /motech-base.deb
RUN dpkg -i motech-base.deb
ADD /motech.deb /motech.deb
RUN dpkg -i motech.deb

EXPOSE 61616 8161
EXPOSE 8080

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]

