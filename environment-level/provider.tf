# Configure the Confluent Provider
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.54.0"
    }
  }
}

# Authenticate with Environment Admin Cloud Key
provider "confluent" {
  cloud_api_key    = var.cloud_api_key
  cloud_api_secret = var.cloud_api_secret
}