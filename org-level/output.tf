output "api_key_env_sa" {
  description = "API Key Environment SA"
  value = confluent_api_key.pn-tf-cloud-key-env-admin.id
}
output "api_secret_env_sa" {
  description = "API Secret Environment SA"
  value = confluent_api_key.pn-tf-cloud-key-env-admin.secret
  sensitive = true
}
output "id_cluster_sa" {
  description = "Cluster SA"
  value = confluent_service_account.pn-tf-cluster-admin.id
}
output "api_key_cluster_sa" {
  description = "API Key Cluster SA"
  value = confluent_api_key.pn-tf-cloud-key-cluster-admin.id
}
output "api_secret_cluster_sa" {
  description = "API Secret Cluster SA"
  value = confluent_api_key.pn-tf-cloud-key-cluster-admin.secret
  sensitive = true
}