FROM  neo4j:3.5.9-enterprise

RUN apt update \
  && apt install -y e2fsprogs zip unzip awscli 

# Install plugins
RUN mkdir -p /var/lib/neo4j/plugins
RUN curl -L -s  https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/3.5.0.4/apoc-3.5.0.4-all.jar > /var/lib/neo4j/plugins/apoc-3.5.0.4-all.jar

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY init_db.sh /init_db.sh

# These were created earlier by image, but we dont need them since
# entrypoint will configure Neo to use them if they exist.
# RUN rm -rf /var/lib/neo4j/data /var/lib/neo4j/logs

EXPOSE 5000 5001 6000 6001 7000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["neo4j"]
