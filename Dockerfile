FROM smatochkin/java:oracle7

# ElasticSearch Version
ENV ES_VERSION 1.3.4

# Install ElasticSearch binaries
RUN curl -Ls https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz | \
    tar xz -C /opt && \
    ln -s elasticsearch-${ES_VERSION} /opt/elasticsearch

# Upload Elasticsearch configuration and startup files
RUN mkdir /etc/service/elasticsearch && \
    mv /opt/elasticsearch/config/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml.orig

ADD config  /opt/elasticsearch/config
ADD service/run /etc/service/elasticsearch/run

# Create and expose data volume
RUN mkdir -p /elasticsearch
VOLUME ["/elasticsearch"]

# Expose communication ports
EXPOSE 9200 9300
