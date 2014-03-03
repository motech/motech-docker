FROM ubuntu:12.04

# Modified version of https://github.com/klaemo/docker-couchdb

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y build-essential wget curl

# erlang
RUN apt-get install -y erlang-base-hipe erlang-xmerl erlang-inets erlang-manpages erlang-dev erlang-nox erlang-eunit

# couch deps
RUN apt-get install -y libmozjs185-dev libicu-dev libcurl4-gnutls-dev libtool

# Get the source
RUN cd /opt && \
 wget http://apache.openmirror.de/couchdb/source/1.5.0/apache-couchdb-1.5.0.tar.gz && \
 tar xzf /opt/apache-couchdb-1.5.0.tar.gz

# build couchdb
RUN cd /opt/apache-couchdb-* && ./configure && make && make install

# install github.com/visionmedia/mon v1.2.3
RUN (mkdir /tmp/mon && cd /tmp/mon && curl -L# https://github.com/visionmedia/mon/archive/1.2.3.tar.gz | tar zx --strip 1 && make install)

# cleanup
RUN apt-get remove -y build-essential wget curl && \
 apt-get autoremove -y && apt-get clean -y && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/apache-couchdb-*

ADD ./opt /opt

# Configuration
RUN mv /opt/local.ini /usr/local/etc/couchdb/
RUN sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /usr/local/etc/couchdb/default.ini
RUN /opt/couchdb-config

# USER couchdb
CMD ["/opt/start_couch"]

EXPOSE 5984