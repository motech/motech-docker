FROM motech/java:openjdk-jre7

RUN apt-get install curl -y

RUN curl http://mirror.ox.ac.uk/sites/rsync.apache.org/activemq/apache-activemq/5.5.1/apache-activemq-5.5.1-bin.tar.gz > apache-activemq-5.5.1-bin.tar.gz
RUN tar xzf apache-activemq-5.5.1-bin.tar.gz

RUN sed -e 's/<broker /<broker schedulerSupport="true" /' -i /apache-activemq-5.5.1/conf/activemq.xml

EXPOSE 61616 8161

CMD ACTIVEMQ_OPTS="-Xms1G -Xmx1G -Dorg.apache.activemq.UseDedicatedTaskRunner=true -Djava.util.logging.config.file=logging.properties" apache-activemq-5.5.1/bin/activemq console
