# Existing environment
data "confluent_environment" "env" {
  id = var.confluent_cloud_environment_id
}

# Create SA
resource "confluent_service_account" "pn-tf-env-admin" {
  display_name = "pn-tf-env-admin"
  description  = "Service account to administrate the environment"
}

# Set EnvironmentAdmin Role to SA
resource "confluent_role_binding" "pn-tf-env-admin" {
  principal   = "User:${confluent_service_account.pn-tf-env-admin.id}"
  role_name   = "EnvironmentAdmin"
  crn_pattern = data.confluent_environment.env.resource_name
}

# Create Cloud API Key for the SA (needed for Environment Level TF management)
resource "confluent_api_key" "pn-tf-cloud-key-env-admin" {
  display_name = "pn-tf-cloud-key-env-admin"
  description  = "Cloud API Key that is owned by pn-tf-env-admin Service Account"
  owner {
    id          = confluent_service_account.pn-tf-env-admin.id
    api_version = confluent_service_account.pn-tf-env-admin.api_version
    kind        = confluent_service_account.pn-tf-env-admin.kind
  }
}