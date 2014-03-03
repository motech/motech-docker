FROM motech/java:oracle-jdk7

RUN apt-get install -y maven wget curl 

# Get the source
RUN cd /opt && \
 wget https://github.com/rnewson/couchdb-lucene/archive/v0.9.0.tar.gz && \
 tar xzf /opt/v0.9.0.tar.gz
RUN mv /opt/couchdb-lucene-0.9.0 /opt/couchdb-lucene-0.9.0.src

# build couchdb-lucene
RUN cd /opt/couchdb-lucene-0.9.0.src && mvn
RUN cd /opt && tar xvzf /opt/couchdb-lucene-0.9.0.src/target/couchdb-lucene-0.9.0-dist.tar.gz 

# install github.com/visionmedia/mon v1.2.3
RUN apt-get install -y make build-essential
RUN (mkdir /tmp/mon && cd /tmp/mon && curl -L# https://github.com/visionmedia/mon/archive/1.2.3.tar.gz | tar zx --strip 1 && make install)

# cleanup
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/couchdb-lucene-0.9.0.src

RUN adduser --system --disabled-password --home /opt/couchdb-lucene-0.9.0 --no-create-home --shell=/bin/bash --group --gecos "" couchdb 

ADD ./opt/start_couch_lucene /opt/start_couch_lucene

RUN sed -e 's/^host=localhost$/host=0.0.0.0/' -i /opt/couchdb-lucene-0.9.0/conf/couchdb-lucene.ini

RUN chown -R couchdb:couchdb /opt/couchdb-lucene-0.9.0
RUN chmod a+x /opt/start_couch_lucene

# USER couchdb
CMD ["/opt/start_couch_lucene"]

EXPOSE 5985