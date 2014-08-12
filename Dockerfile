FROM smatochkin/java:oracle7

# Install ElasticSearch binaries
RUN curl -Ls https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz | \
    tar xz -C /opt && \
    ln -s elasticsearch-1.1.1 /opt/elasticsearch

# Upload Elasticsearch configuration and startup files
RUN mkdir /etc/service/elasticsearch && \
    mv /opt/elasticsearch/config/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml.orig
ADD config/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
ADD service/run /etc/service/elasticsearch/run

# Create and expose data volume
RUN mkdir -p /data/elasticsearch
VOLUME ["/data/elasticsearch"]

# Expose communication ports
EXPOSE 9200 9300
