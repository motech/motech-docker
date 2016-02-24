FROM centos:latest

#Install Java, tomcat, wget, git, maven, activemq, npm
RUN yum update -y
RUN yum install java-1.8.0-openjdk-devel.x86_64 -y
RUN yum install tomcat -y
RUN yum install wget git maven activemq npm -y

#Install and enable mysql server
RUN wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
RUN rpm -ivh mysql-community-release-el7-5.noarch.rpm
RUN yum update -y
RUN yum install mysql-server -y
RUN /usr/bin/systemctl enable mysqld
RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql/

#Install motech RPM
ADD /motech-base.rpm /motech-base.rpm
RUN rpm -i motech-base.rpm
ADD /motech.rpm /motech.rpm
RUN rpm -i motech.rpm


#Install systemd
RUN yum install systemd-sysv -y

ADD run.sh /run.sh
RUN chmod a+x /run.sh


