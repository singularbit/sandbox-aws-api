# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
# GLOBAL VARIABLES
# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
custom_tags    = {}
project_name   = "<project name>"
aws_account_id = "<AWSAccountID>"
aws_region     = "region"
branch_name    = "<the branch you're using>"


# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
# VARIABLES - CLOUDFORMATION - IMPORTS
# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
cloudformation_stack_name = "<the name of the 1st cloudformation stack>" #TODO: (2024-01-12) We need to Import this value!


## --------------------------------------------------------------------------------------------------------------------
## VARIABLES - ROUTE53
## --------------------------------------------------------------------------------------------------------------------
route53_zone_name = "<the domain.tld you'll be using>" # NOTE: not necessary for this current version


## --------------------------------------------------------------------------------------------------------------------
## VARIABLES - CI/CD PIPELINE(S)
## --------------------------------------------------------------------------------------------------------------------
cicd_pipelines = {
  "pipeline-1" = {
    pipeline_repository_branch  = "<the branch you're using>"
    pipeline_repository_name    = "<the repository you're using>"
    codebuild_additional_envars = ""
    codebuild_scripts           = {
      "build"  = "terraform/buildspecs/cicd_pipeline/buildspec_build.yaml"
      "deploy" = "terraform/buildspecs/cicd_pipeline/buildspec_deploy.yaml"
    }
    codebuild_compute_type    = "BUILD_GENERAL1_SMALL"
    codebuild_roles           = []
    codebuild_privileged_mode = true
    codebuild_proxy_config    = {
      HTTP_PROXY  = ""
      http_proxy  = ""
      HTTPS_PROXY = ""
      https_proxy = ""
      NO_PROXY    = ""
      no_proxy    = ""
    }
    lambda_handler              = "function-1.index"
    lambda_runtime              = "python3.8"
    lambda_filename             = "function-1"
    api_http_method             = "GET"
    api_authorization           = "NONE"
    api_integration_http_method = "POST"
    api_type                    = "AWS_PROXY"
  }
}