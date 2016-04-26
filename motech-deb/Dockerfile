FROM ubuntu:15.04

RUN apt-get update

#Install simple tool for installing deb files
RUN apt-get install gdebi-core -y

#Install mysql-server and set password to 'password'
RUN echo "mysql-server mysql-server/root_password password password" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password password" | debconf-set-selections
RUN apt-get install -y mysql-server

#Install motech DEB with dependencies
ADD /motech-base.deb /motech-base.deb
RUN gdebi --non-interactive motech-base.deb
ADD /motech.deb /motech.deb
RUN gdebi --non-interactive motech.deb

EXPOSE 8080

ADD run.sh /run.sh
RUN chmod a+x /run.sh

CMD ["/run.sh"]

