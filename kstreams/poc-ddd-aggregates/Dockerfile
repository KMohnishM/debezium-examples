FROM registry.access.redhat.com/ubi8/ubi-minimal:8.4

ARG JAVA_PACKAGE=java-11-openjdk-headless
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en'

RUN microdnf install -y curl ${JAVA_PACKAGE} \
    && microdnf clean all \
    && mkdir -p /opt/poc-ddd-aggregates/lib

COPY target/dependencies/* /opt/poc-ddd-aggregates/lib/
COPY target/poc-ddd-aggregates-*.jar /opt/poc-ddd-aggregates/lib/
COPY run-aggregator.sh /opt/poc-ddd-aggregates/run-aggregator.sh
RUN chmod +x /opt/poc-ddd-aggregates/run-aggregator.sh

WORKDIR /opt/poc-ddd-aggregates
CMD ["/opt/poc-ddd-aggregates/run-aggregator.sh"]
