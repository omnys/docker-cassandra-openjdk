FROM java:openjdk-8-jre

MAINTAINER Omnys srl <sistemi@omnys.com>

ENV DEBIAN_FRONTEND noninteractive
ENV CASSANDRA_CONFIG /etc/cassandra
ENV CASSANDRA_VERSION = 2.2.6
ENV DATASTAX_COMMUNITY_VERSION = 2.2.6-1

# Add DataStax sources
RUN curl -L http://debian.datastax.com/debian/repo_key | apt-key add -
RUN echo "deb http://debian.datastax.com/community stable main" > /etc/apt/sources.list.d/datastax.list

# Workaround for https://github.com/docker/docker/issues/6345
RUN ln -s -f /bin/true /usr/bin/chfn

# Install Cassandra and clean apt
RUN apt-get update && \
    apt-get install -y cassandra=$CASSANDRA_VERSION dsc22=$DATASTAX_COMMUNITY_VERSION && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
