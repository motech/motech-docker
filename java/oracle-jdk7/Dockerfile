FROM ubuntu:12.04

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
