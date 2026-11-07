ARG DEBEZIUM_VERSION
FROM quay.io/debezium/example-postgres:${DEBEZIUM_VERSION:-latest}

COPY schema-update.sql /docker-entrypoint-initdb.d/zzz-schema-update.sql
