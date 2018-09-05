#
# wikidata-query-rdf sparql
# @author Loreto Parisi (loretoparisi at gmail dot com)
# v1.0.0
# @see https://github.com/wikimedia/wikidata-query-rdf
# Copyright (c) 2018 Loreto Parisi - https://github.com/loretoparisi/docker
#
FROM ubuntu:16.04

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

# working directory
ENV HOME /root
ENV NODE_VERSION lts
WORKDIR $HOME

# packages list
RUN \
	apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    npm \
    maven

# install java
RUN curl http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-9.0.1_linux-x64_bin.tar.gz > jdk-9.0.1_linux-x64_bin.tar.gz
RUN tar xvzf jdk-9.0.1_linux-x64_bin.tar.gz -C $HOME
RUN chown -R root:root jdk-9.0.1
ENV JAVA_HOME $HOME/jdk-9.0.1
ENV PATH $PATH:$JAVA_HOME/bin/

# install Node.js
RUN npm install n -g
RUN n $NODE_VERSION

# clone and install wikidata
RUN git clone --recurse-submodules https://github.com/wikimedia/wikidata-query-rdf wikidata-query-rdf
RUN \
    cd $HOME/wikidata-query-rdf && \
    mvn package

# install Blazegraph, Jetty launcher, launch scripts, and configuration
RUN apt-get -s -y install zip unzip
RUN \
    cd $HOME/wikidata-query-rdf/dist/target && \
    unzip -q -o ./service-*-dist.zip && \
    cd service-*/ && \
    cp -r $(pwd) $HOME/blazegraph/

# copy utility scripts
COPY script $HOME/script

# overwrite Blazegraph properties file
# change journal file location
COPY blazegraph/RWStore.properties $HOME/blazegraph/
# fix this replace and remove the absolute path from properties file
#RUN sed -i "s/com.bigdata.journal.AbstractJournal.file=wikidata.jnl/com.bigdata.journal.AbstractJournal.file=$HOME\/data\/wikidata.jnl/g" $HOME/blazegraph/RWStore.properties
ENV DATA_ROOT $HOME/data
WORKDIR $HOME/blazegraph

CMD ["bash"]
