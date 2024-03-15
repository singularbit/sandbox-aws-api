## ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
## GLOBAL VARIABLES
## ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
variable "custom_tags" {
  description = "Custom tags to apply to all resources"
  type        = map(any)
  default     = {}
}
variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = ""
}
variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
  default     = ""
}
variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = ""
}
variable "branch_name" {
  description = "The name of the branch"
  type        = string
  default     = ""
}

## ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
## CLOUDFORMATION IMPORTS
## ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
variable "cloudformation_stack_name" {
  description = "The name of the CloudFormation stack"
  type        = string
  default     = ""
}

# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
# Route53
# ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
variable "route53_zone_name" {
  description = "The name of the Route53 zone"
  type        = string
  default     = ""
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - CI/CD PIPELINE(S)
# ---------------------------------------------------------------------------------------------------------------------
variable "cicd_pipelines" {
  description = "CI/CD Pipelines"
  type        = map(object({
    pipeline_repository_name    = string
    pipeline_repository_branch  = string
    codebuild_additional_envars = string
    codebuild_scripts           = map(any)
    codebuild_compute_type      = string
    codebuild_roles             = list(any)
    codebuild_privileged_mode   = bool
    codebuild_proxy_config      = object({
      HTTP_PROXY  = string
      http_proxy  = string
      HTTPS_PROXY = string
      https_proxy = string
      NO_PROXY    = string
      no_proxy    = string
    })
    lambda_handler              = string
    lambda_runtime              = string
    lambda_filename             = string
    api_http_method             = string
    api_authorization           = string
    api_integration_http_method = string
    api_type                    = string
  }))
  default = {}
}