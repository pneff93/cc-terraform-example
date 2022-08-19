output "cluster-id"{
  description = "Cluster Id"
  value = confluent_kafka_cluster.basic.id
}

output "api_key" {
  description = "API Key"
  value = confluent_api_key.pn-tf-clients-key.id
}
output "api_secret" {
  description = "API Secret"
  value = confluent_api_key.pn-tf-clients-key.secret
  sensitive = true
}