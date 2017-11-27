#
# SKIL Community Edition (SKIL CE) 
# gives developers an easy way to train and deploy powerful deep learning models to production quickly and easily.
# Currently the SKIL Community Edition only supports Centos 7 and Redhat 7 operating systems.
# @see https://skymind.ai/quickstart
#
# Copyright (c) 2017 Loreto Parisi - https://github.com/loretoparisi/docker
#

FROM centos:7

MAINTAINER Loreto Parisi <loretoparisi@gmail.com>

ENV HOME /root
WORKDIR $HOME

# install dependecies
RUN \
    yum install -y sudo \
    sudo yum clean all \
    sudo yum install -y skil-server \
    sudo yum install -y policycoreutils

# yum repo config
COPY skymind.repo /etc/yum.repos.d/

# install skil server
RUN \
    sudo yum install -y skil-server

# disable SELinux
#RUN \
    # disable SELinux temporarily
    # setenforce Permissive && \
    # disable SELinux permanently
    #sudo sed -i 's/SELinux=enforcing/SELinux=disabled/' /etc/sysconfig/selinux
    
# SELinux check
RUN sestatus

VOLUME /run /tmp

ADD cmd.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/cmd.sh

CMD ["/usr/local/bin/cmd.sh"]
