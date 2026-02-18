# Pull base image.
FROM opensearchproject/opensearch:1.2.0

#ENV ES_PKG_NAME elasticsearch-1.5.0

# Install Elasticsearch.
#RUN sudo apt install openjdk-11-jdk -y
#RUN curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
#RUN sudo echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
#RUN sudo apt update
#RUN sudo apt install elasticsearch -y
#RUN sudo service elasticsearch start

# Define mountable directories.
#VOLUME ["/data"]

# Mount elasticsearch.yml config
#ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
#WORKDIR /data

# Define default command.
#CMD ["elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
#EXPOSE 9200
#EXPOSE 9300