ARG DEBEZIUM_VERSION=3.7
FROM maven:3.9-eclipse-temurin-11 AS build
RUN git clone https://github.com/hpgrahsl/kafka-connect-mongodb.git /tmp/kafka-connect-mongodb && \
  cd /tmp/kafka-connect-mongodb && \
  git checkout tags/v1.2.0 && \
  sed -i 's|http://packages.confluent.io/maven/|https://packages.confluent.io/maven/|g' pom.xml && \
  mvn clean package -DskipTests=true -DskipITs=true

FROM quay.io/debezium/connect:${DEBEZIUM_VERSION}
ENV KAFKA_CONNECT_MONGODB_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-mongodb

USER root
RUN mkdir -p $KAFKA_CONNECT_MONGODB_DIR
COPY --from=build /tmp/kafka-connect-mongodb/target/kafka-connect-mongodb/kafka-connect-mongodb-1.2.0-jar-with-dependencies.jar $KAFKA_CONNECT_MONGODB_DIR/

USER kafka
