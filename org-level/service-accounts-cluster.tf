# Create SA
resource "confluent_service_account" "pn-tf-cluster-admin" {
  display_name = "pn-tf-cluster-admin"
  description  = "Service account to administrate the CC cluster"
}

# Create Cloud API Key for the SA (needed for cluster level TF management)
resource "confluent_api_key" "pn-tf-cloud-key-cluster-admin" {
  display_name = "pn-tf-cloud-key-cluster-admin"
  description  = "Cloud API Key that is owned by pn-tf-cluster-admin Service Account"
  owner {
    id          = confluent_service_account.pn-tf-cluster-admin.id
    api_version = confluent_service_account.pn-tf-cluster-admin.api_version
    kind        = confluent_service_account.pn-tf-cluster-admin.kind
  }
}

