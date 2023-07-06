# Configure the Confluent Provider
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.34.0"
    }
  }
}

# Authenticate
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

# Environment
data "confluent_environment" "confluent_cloud_environment" {
  id = "t39221"
}

# Create cluster within Environment
resource "confluent_kafka_cluster" "basic" {
  display_name = "pn-tf"
  availability = "SINGLE_ZONE"
  cloud        = "AZURE"
  region       = "centralus"
  basic {}

  environment {
    id = data.confluent_environment.confluent_cloud_environment.id
  }
}

# Create Service Account
resource "confluent_service_account" "pn-tf-sa" {
  display_name = "pn-tf-sa-api-key-rotation"
  description  = "Service account for API key rotation"
}

module "api-key-rotation" {
  source  = "nerdynick/api-key-rotation/confluent"
  version = "0.1.0"

  # Required Inputs for Kafka cluster API key
  owner = {
    id          = confluent_service_account.pn-tf-sa.id
    api_version = confluent_service_account.pn-tf-sa.api_version
    kind        = confluent_service_account.pn-tf-sa.kind
  }

  resource = {
    id          = confluent_kafka_cluster.basic.id
    api_version = confluent_kafka_cluster.basic.api_version
    kind        = confluent_kafka_cluster.basic.kind

    environment = {
      id = data.confluent_environment.confluent_cloud_environment.id
    }
  }

  # Optional Inputs for the key rotation
  key_display_name = "Service Account API Key - {date} - Managed by Terraform"
  num_keys_to_retain = 2
  roll_ttl_days = 1
}