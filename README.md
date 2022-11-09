# Kafka Terraform Example
We try out the [Confluent Terraform Provider](https://docs.confluent.io/cloud/current/get-started/terraform-provider.html).
We want to create 
* Kafka Cluster within an existing Environment
by a SA having [EnvironmentAdmin Role](https://docs.confluent.io/cloud/current/access-management/access-control/cloud-rbac.html#environmentadmin)

## Prerequisites

* Create SA and assign EnvironmentAdmin Role
* Create Cloud API Key for this SA


## Run Terraform

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
