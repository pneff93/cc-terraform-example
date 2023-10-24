# Create cluster within Environment
resource "confluent_kafka_cluster" "basic" {
  display_name = "pn-tf-playground"
  availability = "SINGLE_ZONE"
  cloud        = "AWS"
  region       = "eu-central-1"
  basic {}

  environment {
    id = var.environment_id
  }
}
