module "org-level" {
  source = "./org-level"

  cloud_api_key = var.cloud_api_key
  cloud_api_secret = var.cloud_api_secret

  environment_id = var.environment_id
}

module "environment-level" {
  source = "./environment-level"

  environment_id = var.environment_id

  cloud_api_key = module.org-level.cloud_api_key_env_sa
  cloud_api_secret = module.org-level.cloud_api_secret_env_sa

  cluster_sa = module.org-level.cluster_sa_id
}

module "cluster-level" {
  source = "./cluster-level"

  cloud_api_key = module.org-level.cloud_api_key_cluster_sa
  cloud_api_secret = module.org-level.cloud_api_secret_cluster_sa

  environment_id = var.environment_id

  cc_cluster_id = module.environment-level.cluster_id
  cluster_api_key = module.environment-level.api_key
  cluster_api_secret = module.environment-level.api_secret
}