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

# Create Service Account
resource "confluent_service_account" "pn-tf-sa" {
  display_name = "pn-tf-sa"
  description  = "Service Account for Producer by Terraform Example"
}

# Create API Key for that Service Account
resource "confluent_api_key" "pn-tf-sa-kafka-api-key" {
  display_name = "pn-tf-sa-kafka-api-key"
  description  = "Kafka API Key that is owned by pn-tf-sa Service Account"
  owner {
    id          = confluent_service_account.pn-tf-sa.id
    api_version = confluent_service_account.pn-tf-sa.api_version
    kind        = confluent_service_account.pn-tf-sa.kind
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
