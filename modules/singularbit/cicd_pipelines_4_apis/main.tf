# ---------------------------------------------------------------------------------------------------------------------
# CICD PIPELINE
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "cicd_pipeline" {
  for_each = var.cicd_pipelines

  source = "./modules/pipeline"

  depends_on = [
    module.s3_4_codepipeline_artifacts,
    module.s3_4_codebuild_logs
  ]

  custom_tags  = var.custom_tags
  project_name = var.project_name

  # ARTIFACTS
  s3_bucket_codepipeline_artifacts = module.s3_4_codepipeline_artifacts[each.key].s3_bucket

  # IAM
  s3_arn_codepipeline_artifacts = module.s3_4_codepipeline_artifacts[each.key].s3_arn

  # CODESTAR CONNECTION
  codestar_connection_arn = var.codestar_connection_arn

  # PIPELINE
  key               = each.key
  repository_name   = each.value.pipeline_repository_name
  repository_branch = each.value.pipeline_repository_branch

  # CODEBUILD
  codebuild_scripts         = each.value.codebuild_scripts
  codebuild_compute_type    = each.value.codebuild_compute_type
  codebuild_roles           = each.value.codebuild_roles
  codebuild_privileged_mode = each.value.codebuild_privileged_mode
  codebuild_proxy_config    = each.value.codebuild_proxy_config
  codebuild_logs_s3_id      = module.s3_4_codebuild_logs[each.key].s3_id

  # LAMBDA
  lambda_filename = each.value.lambda_filename
}

# ---------------------------------------------------------------------------------------------------------------------
# S3 ARTIFACT LOCATION FOR CODEPIPELINE AND CODEBUILD
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "s3_4_codepipeline_artifacts" {
  for_each = var.cicd_pipelines

  source = "../s3"

  bucket_name = "${var.project_name}-${each.key}-codepipeline-artifacts-${var.account_id_4_chars}"

  use_bucket_server_side_encryption_configuration = true

  set_bucket_acl_private         = true
  set_bucket_versioning_enabled  = true
  set_bucket_policy_access_block = true

  set_bucket_ownership_controls = true
  object_ownership              = "BucketOwnerPreferred" # "BucketOwnerEnforced,ObjectWriter,BucketOwnerPreferred"

  set_s3_bucket_website_configuration = false

  set_s3_bucket_policy = false

  custom_tags = merge({
    "Name" = "${var.project_name}-${each.key}-codepipeline-artifacts-${var.account_id_4_chars}"
  }, var.custom_tags)
}

# ---------------------------------------------------------------------------------------------------------------------
# S3 LOGS LOCATION FOR CODEBUILD
# [Keep this resource for the duration of the project]
# ---------------------------------------------------------------------------------------------------------------------
module "s3_4_codebuild_logs" {
  for_each = var.cicd_pipelines

  source = "../s3"

  bucket_name = "${var.project_name}-${each.key}-codebuild-logs-${var.account_id_4_chars}"

  use_bucket_server_side_encryption_configuration = true

  set_bucket_acl_private         = true
  set_bucket_versioning_enabled  = false
  set_bucket_policy_access_block = true

  set_bucket_ownership_controls = true
  object_ownership              = "BucketOwnerPreferred" # "BucketOwnerEnforced,ObjectWriter,BucketOwnerPreferred"

  set_s3_bucket_website_configuration = false

  set_s3_bucket_policy = false

  custom_tags = merge({
    "Name" = "${var.project_name}-${each.key}-codebuild-logs-${var.account_id_4_chars}"
  }, var.custom_tags)
}
