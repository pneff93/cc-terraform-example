variable "environment_id" {
  description = "Confluent Cloud Environment Id"
  type = string
  sensitive = true
}

variable "cloud_api_key" {
  description = "Confluent Cloud API Key by EnvAdmin"
  type = string
  sensitive = true
}

variable "cloud_api_secret" {
  description = "Confluent Cloud API Secret by EnvAdmin"
  type = string
  sensitive = true
}

variable "cluster_sa" {
  description = "SA that will be the Cluster Admin"
  type = string
}
