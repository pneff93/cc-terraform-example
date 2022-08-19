output "api_key" {
  description = "API Key"
  value = confluent_api_key.pn-tf-sa-kafka-api-key.id
}
output "api_secret" {
  description = "API Secret"
  value = confluent_api_key.pn-tf-sa-kafka-api-key.secret
  sensitive = true
}