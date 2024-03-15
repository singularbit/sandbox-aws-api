module "iam" {
  for_each = var.cicd_pipelines

  source = "./modules/iam"

  custom_tags  = var.custom_tags
  project_name = var.project_name

  key = each.key

}

module "lambda" {
  for_each = var.cicd_pipelines

  source = "./modules/lambda"

  custom_tags  = var.custom_tags
  project_name = var.project_name

  key = each.key

  role     = module.iam[each.key].lambda_execution_role_arn
  handler  = each.value.lambda_handler
  runtime  = each.value.lambda_runtime
  filename = each.value.lambda_filename
}

module "api" {
  for_each = var.cicd_pipelines

  source = "./modules/api"

  custom_tags  = var.custom_tags
  project_name = var.project_name

  key = each.key

  http_method             = each.value.api_http_method
  authorization           = each.value.api_authorization
  integration_http_method = each.value.api_integration_http_method
  type                    = each.value.api_type

  lambda_invoke_arn = module.lambda[each.key].lambda_invoke_arn
  lambda_name       = module.lambda[each.key].lambda_name

}