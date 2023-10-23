# Existing SA
data "confluent_service_account" "cluster-sa" {
  id = var.confluent_sa_cluster_admin
}

# Set CloudClusterAdmin to pn-tf-cluster-admin SA
resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
  principal   = "User:${var.confluent_sa_cluster_admin}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.basic.rbac_crn
}

# Create Cluster API Key for the SA (needed for Cluster interaction e.g. topic creation)
resource "confluent_api_key" "pn-tf-kafka-key-kafka-cluster-admin" {
  display_name = "pn-tf-kafka-key-kafka-cluster-admin"
  description  = "Cluster API Key that is owned by pn-tf-cluster-admin Service Account"
  owner {
    id          = data.confluent_service_account.cluster-sa.id
    api_version = data.confluent_service_account.cluster-sa.api_version
    kind        = data.confluent_service_account.cluster-sa.kind
  }
  managed_resource {
    id          = confluent_kafka_cluster.basic.id
    api_version = confluent_kafka_cluster.basic.api_version
    kind        = confluent_kafka_cluster.basic.kind

    environment {
      id = var.confluent_cloud_environment_id
    }
  }
}