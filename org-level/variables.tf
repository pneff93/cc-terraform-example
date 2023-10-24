variable "cloud_api_key" {
  description = "Confluent Cloud API Key from OrgAdmin"
  type = string
  sensitive = true
}

variable "cloud_api_secret" {
  description = "Confluent Cloud API Secret from OrgAdmin"
  type = string
  sensitive = true
}

variable "environment_id" {
  description = "Confluent Cloud Environment Id"
  type = string
  sensitive = true
}
