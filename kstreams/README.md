# Debezium KStreams Example

This demo shows how to join two CDC event streams created by Debezium into a single topic and
sink the aggregated change events into MongoDB, using the [Kafka Connect MongoDB sink connector](https://github.com/hpgrahsl/kafka-connect-mongodb).

## Preparations

```shell
# Build aggregator application
mvn clean package -f poc-ddd-aggregates/pom.xml -DskipTests

# Start Kafka, Kafka Connect, a MySQL and a MongoDB database and the aggregator
docker compose --env-file ../.env up --build -d

# Start MySQL connector
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8083/connectors/ -d @mysql-source.json

# Start MongoDB sink connector
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" http://localhost:8084/connectors/ -d @mongodb-sink.json
```

# Consume aggregated messages

Browse the Kafka topic:

```shell
docker compose --env-file ../.env exec -T kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic final_ddd_aggregates
```

Examine the target collection in the MongoDB sink database:

```shell
docker compose --env-file ../.env exec -T mongodb mongosh inventory --eval "db.customers_with_addresses.find().pretty()"
```

# Modify records in the source database via MySQL client

```shell
docker compose --env-file ../.env exec -T mysql mysql -uroot -pdebezium inventory -e 'UPDATE customers SET first_name = "Sarah" WHERE id = 1001;'
```

The corresponding aggregate should be updated in MongoDB.

# Shut down the cluster

```shell
docker compose --env-file ../.env down -v
```
