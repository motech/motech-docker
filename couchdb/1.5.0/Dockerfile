FROM ubuntu:12.04

#
# Instal Oracle JDK
RUN rm /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise main universe multiverse > /etc/apt/sources.list

RUN apt-get update

# Install Java
RUN apt-get install --yes python-software-properties
RUN add-apt-repository --yes ppa:webupd8team/java
RUN apt-get update

# Set some vars so the oracle installer doesn't ask us to accept the license
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

RUN apt-get install --yes oracle-java7-installer

#
# Modified version of https://github.com/klaemo/docker-couchdb
#

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y build-essential maven wget curl

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
RUN apt-get remove -y build-essential && \
 apt-get autoremove -y && apt-get clean -y && \
 rm -rf /tmp/* /var/tmp/* /opt/apache-couchdb-*

ADD ./opt /opt

# Configuration
RUN mv /opt/local.ini /usr/local/etc/couchdb/
RUN sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /usr/local/etc/couchdb/default.ini
RUN /opt/couchdb-config

#
# Lucene
#

# Get the source
RUN cd /opt && \
 wget https://github.com/rnewson/couchdb-lucene/archive/v0.9.0.tar.gz && \
 tar xzf /opt/v0.9.0.tar.gz
RUN mv /opt/couchdb-lucene-0.9.0 /opt/couchdb-lucene-0.9.0.src

# build couchdb-lucene
RUN cd /opt/couchdb-lucene-0.9.0.src && mvn
RUN cd /opt && tar xvzf /opt/couchdb-lucene-0.9.0.src/target/couchdb-lucene-0.9.0-dist.tar.gz 

# cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/couchdb-lucene-0.9.0.src

RUN adduser --system --disabled-password --home /opt/couchdb-lucene-0.9.0 --no-create-home --shell=/bin/bash --group --gecos "" couchdb 

RUN sed -e 's/^host=localhost$/host=0.0.0.0/' -i /opt/couchdb-lucene-0.9.0/conf/couchdb-lucene.ini

RUN chown -R couchdb:couchdb /opt/couchdb-lucene-0.9.0

# USER couchdb
CMD ["/opt/start_couch"]

EXPOSE 5984
EXPOSE 5985