# Configure the Confluent Provider
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.1.0"
    }
  }
}

# Authenticate
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

# Create cluster within environment
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