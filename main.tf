# Configure the Confluent Provider
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.2.0"
    }
  }
}

# Authenticate
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

# Create cluster within Environment
resource "confluent_kafka_cluster" "basic" {
  display_name = "pn-tf"
  availability = "SINGLE_ZONE"
  cloud        = "AWS"
  region       = "eu-central-1"
  basic {}

  environment {
    id = var.confluent_cloud_environment_id
  }
}

# Admin
# Create Service Account as an Admin
resource "confluent_service_account" "pn-tf-cloud-admin" {
  display_name = "pn-tf-cloud-admin"
  description  = "Service account to administrate the cluster"
}

# Set CloudClusterAdmin Role to Admin Account
resource "confluent_role_binding" "pn-tf-cloud-admin" {
  principal   = "User:${confluent_service_account.pn-tf-cloud-admin.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.basic.rbac_crn
}

# Create API Key for the Admin Account
resource "confluent_api_key" "pn-tf-cloud-admin-key" {
  display_name = "pn-tf-cloud-admin-key"
  description  = "Kafka API Key that is owned by pn-tf-cloud-admin Service Account"
  owner {
    id          = confluent_service_account.pn-tf-cloud-admin.id
    api_version = confluent_service_account.pn-tf-cloud-admin.api_version
    kind        = confluent_service_account.pn-tf-cloud-admin.kind
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


# Clients
# Create Service Account for Clients
resource "confluent_service_account" "pn-tf-clients" {
  display_name = "pn-tf-clients"
  description  = "Service Account for Producer and Consumer Clients"
}

# Create API Key for that Service Account
resource "confluent_api_key" "pn-tf-clients-key" {
  display_name = "pn-tf-clients-key"
  description  = "Kafka API Key that is owned by pn-tf-clients Service Account"
  owner {
    id          = confluent_service_account.pn-tf-clients.id
    api_version = confluent_service_account.pn-tf-clients.api_version
    kind        = confluent_service_account.pn-tf-clients.kind
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

# Create ACLs to create, write and read from a Kafka Topic
# for the Clients Service Account
resource "confluent_kafka_acl" "operate-topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.basic.id
  }
  resource_type = "TOPIC"
  resource_name = "*"
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.pn-tf-clients.id}"
  host          = "*"
  operation     = "ALL"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.basic.rest_endpoint
  credentials {
    key    = confluent_api_key.pn-tf-cloud-admin-key.id
    secret = confluent_api_key.pn-tf-cloud-admin-key.secret
  }
}

resource "confluent_kafka_acl" "consume-topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.basic.id
  }
  resource_type = "GROUP"
  resource_name = "test-group"
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.pn-tf-clients.id}"
  host          = "*"
  operation     = "READ"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.basic.rest_endpoint
  credentials {
    key    = confluent_api_key.pn-tf-cloud-admin-key.id
    secret = confluent_api_key.pn-tf-cloud-admin-key.secret
  }
}

# Create Kafka Topic by Clients Service Account
resource "confluent_kafka_topic" "test-topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.basic.id
  }
  topic_name         = "test-topic"
  partitions_count   = 6
  rest_endpoint      = confluent_kafka_cluster.basic.rest_endpoint
  config = {
    "cleanup.policy"    = "compact"
  }
  credentials {
    key    = confluent_api_key.pn-tf-cloud-admin-key.id
    secret = confluent_api_key.pn-tf-cloud-admin-key.secret
  }
}