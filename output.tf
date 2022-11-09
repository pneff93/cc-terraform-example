output "cluster-id"{
  description = "Cluster Id"
  value = confluent_kafka_cluster.basic.id
}

output "bootstrap_server" {
  description = "Bootstrap Server"
  value = confluent_kafka_cluster.basic.bootstrap_endpoint
}