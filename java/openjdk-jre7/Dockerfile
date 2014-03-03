FROM ubuntu:12.04

RUN rm /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu precise main universe multiverse > /etc/apt/sources.list

RUN apt-get update
RUN apt-get install openjdk-7-jre-headless -y