# Kafka Terraform Example
We try out the [Confluent Terraform Provider](https://docs.confluent.io/cloud/current/get-started/terraform-provider.html).
We want to create 
* Kafka Cluster within an existing Environment
* Service Account (Admin and Client)
* API Keys (Admin and Client)
* ACLs provided by the Admin to the Client to create, write, and read a Kafka Topic
* Kafka Topic

Then we want to produce and consume data to that topic with the configured API Key.

## Run Terraform

Add the provider so that we have the Confluent Terraform Provider
```terraform
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.2.0"
    }
  }
}
```

We encrypted sensitive information (variables.tf) with [Blackbox](https://github.com/StackExchange/blackbox).
This contains the `environment id`, as well as the `cloud API key` and `cloud API secret`.

Initialize Terraform for that project:
```shell
terraform init
```

Then we always work with:

```shell
terraform plan
```
```shell
terraform apply
```
```shell
terraform destroy
```

To see output variables such as the API Key and Secret, we need to
execute:
```shell
terraform output api_secret
```

## Confluent CLI to validate resources

We need to login and use the desired environment and cluster with the Confluent CLI.
Then we can see all resources by:

```shell
confluent iam service-account list
``` 
```shell
confluent api-key list --resource <clusterId>
```
```shell
confluent kafka acl list
```
```shell
confluent kafka topic list --cluster <clusterId>
```

## Produce and Consume data
Before producing or consuming data edit the appropriate [client.properties](client.properties).
```shell
kafka-console-producer  --broker-list <brokerId> --topic test-topic --producer.config client.properties --property "parse.key=true" --property "key.separator=:"
```

```shell
kafka-console-consumer --bootstrap-server <brokerId> --topic test-topic --consumer.config client.properties --group test-group --from-beginning
```

## Resources
* [Confluent Docu](https://docs.confluent.io/cloud/current/get-started/terraform-provider.html)
* [Example](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/guides/sample-project)
* [Example main.tf](https://github.com/confluentinc/terraform-provider-confluent/blob/master/examples/configurations/basic-kafka-acls/main.tf)