# Confluent Cloud Terraform Example
We try out the [Confluent Terraform Provider](https://docs.confluent.io/cloud/current/get-started/terraform-provider.html).
We want to create a simple setup consisting 

* Service Accounts with corresponding permission scope
* Kafka Cluster within an existing Environment
* Several Kafka Topics

To do so, we define three scope levels
* Organization
* Environment
* Cluster

In the organization level, we create all SA since we need OrgAdmin/Account Admin role binding.
On the environment one, all actions are executed 
by a SA having EnvironmentAdmin Role or CloudClusterAdmin, respectively.


## Prerequisites

* Have an account with OrgAdmin/Account Admin role binding and a Cloud API Key/Secret


## Run Terraform

We encrypted sensitive information (variables.tf) with [Blackbox](https://github.com/StackExchange/blackbox).

Initialize Terraform for that project (for each scope level):
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
