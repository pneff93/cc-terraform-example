variable "environment_id" {
  description = "Confluent Cloud Environment Id"
  type = string
  sensitive = true
}

variable "cc_cluster_id" {
  description = "Confluent Cloud Cluster Id"
  type = string
  sensitive = true
}

variable "cloud_api_key" {
  description = "Confluent Cloud API Key by CloudClusterAdmin -> from OrgLevel"
  type = string
  sensitive = true
}

variable "cloud_api_secret" {
  description = "Confluent Cloud API Secret by CloudClusterAdmin -> from OrgLevel"
  type = string
  sensitive = true
}

variable "cluster_api_key" {
  description = "Confluent Cluster API Key by CloudClusterAdmin -> from EnvironmentLevel"
  type = string
  sensitive = true
}

variable "cluster_api_secret" {
  description = "Confluent Cluster API Secret by CloudClusterAdmin --> from EnvironmentLevel"
  type = string
  sensitive = true
}