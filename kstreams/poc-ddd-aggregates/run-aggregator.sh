#!/bin/bash
exec java -cp "/opt/poc-ddd-aggregates/lib/*" io.debezium.examples.aggregation.StreamingAggregatesDDD "$PARENT_TOPIC" "$CHILDREN_TOPIC" "$BOOTSTRAP_SERVERS"
