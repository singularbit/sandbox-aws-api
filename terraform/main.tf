
### CI/CD Pipeline
module "codestar_connection" {
  source = "../modules/singularbit/codestar_conn"

  codestar_connection_name          = "labsapi_conn"
  codestar_connection_provider_type = "GitHub"
}

module "cicd_pipelines_4_apis" {

  source = "../modules/singularbit/cicd_pipelines_4_apis"

  custom_tags        = local.custom_tags
  project_name       = var.project_name
  account_id_4_chars = substr(var.aws_account_id, -4, 4)

  codestar_connection_arn = module.codestar_connection.codestar_connection_arn

  cicd_pipelines = var.cicd_pipelines
}

### APIs
module "apis" {
  source = "../modules/singularbit/apis"

  custom_tags        = local.custom_tags
  project_name       = var.project_name
  account_id_4_chars = substr(var.aws_account_id, -4, 4)

  cicd_pipelines = var.cicd_pipelines

}
