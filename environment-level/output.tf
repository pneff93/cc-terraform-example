output "api_key" {
  description = "Cluster API Key"
  value = confluent_api_key.pn-tf-kafka-key-kafka-cluster-admin.id
}
output "api_secret" {
  description = "Cluster API Secret"
  value = confluent_api_key.pn-tf-kafka-key-kafka-cluster-admin.secret
  sensitive = true
}