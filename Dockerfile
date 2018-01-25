FROM ubuntu:16.04
MAINTAINER Nitin Goswami

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y software-properties-common && apt-get install -y python-software-properties && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer


# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


RUN apt-get update && apt-get install -y vim net-tools xinetd telnetd iputils-ping telnet sudo curl supervisor

#zookeeper version
ENV ZOOKEEPER_VERSION 3.4.10

# Download zookeeper
RUN cd /opt && \
  curl -O "http://download.nextag.com/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz"   && \
	tar xzvf zookeeper-3.4.10.tar.gz && \
  rm -f zookeeper-3.4.10.tar.gz && \
	mv /opt/zookeeper-3.4.10 /opt/zookeeper  && \
	mkdir /mnt/data && \
	mkdir /mnt/logs 

COPY conf/zoo.cfg /opt/zookeeper/conf/zoo.cfg

COPY conf/alian /opt/zookeeper/conf/alian

EXPOSE 2181 2888 3888

