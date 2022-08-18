# Kafka Terraform Example
We try out the Confluent Terraform Provider.
We want to create 
* Kafka Cluster within an existing Environment
* Kafka Topic
* Service Account
* API Key
* ACLs to write to that topic

Then we want to produce data to that topic with the configured API Key.

## Run

Add the provider so that we have the Confluent Terraform Provider
```terraform
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.1.0"
    }
  }
}
```

We encrypted sensitive information (variables.tf) with [Blackbox](https://github.com/StackExchange/blackbox).

```shell
terraform init
```

Then we always work with

```shell
terraform plan
```
```shell
terraform apply
```
```shell
terraform destroy
```

## Resources
* [Confluent Docu](https://docs.confluent.io/cloud/current/get-started/terraform-provider.html)
* [Example](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/guides/sample-project)