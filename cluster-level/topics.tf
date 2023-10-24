# Existing cluster
data "confluent_kafka_cluster" "cluster" {
  id = var.cc_cluster_id
  environment {
    id = var.environment_id
  }
}

# Create Topics
resource "confluent_kafka_topic" "orders" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  topic_name         = "orders"
  rest_endpoint      = data.confluent_kafka_cluster.cluster.rest_endpoint
  credentials {
    key    = var.cluster_api_key
    secret = var.cluster_api_secret
  }
}

resource "confluent_kafka_topic" "payments" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  topic_name         = "payments"
  rest_endpoint      = data.confluent_kafka_cluster.cluster.rest_endpoint
  credentials {
    key    = var.cluster_api_key
    secret = var.cluster_api_secret
  }
}