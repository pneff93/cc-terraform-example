output "cloud_api_key_env_sa" {
  description = "Cloud API Key Environment SA"
  value = confluent_api_key.pn-tf-cloud-key-env-admin.id
}
output "cloud_api_secret_env_sa" {
  description = "Cloud API Secret Environment SA"
  value = confluent_api_key.pn-tf-cloud-key-env-admin.secret
  sensitive = true
}
output "cluster_sa_id" {
  description = "Cluster SA Id"
  value = confluent_service_account.pn-tf-cluster-admin.id
}
output "cloud_api_key_cluster_sa" {
  description = "API Key Cluster SA"
  value = confluent_api_key.pn-tf-cloud-key-cluster-admin.id
}
output "cloud_api_secret_cluster_sa" {
  description = "API Secret Cluster SA"
  value = confluent_api_key.pn-tf-cloud-key-cluster-admin.secret
  sensitive = true
}