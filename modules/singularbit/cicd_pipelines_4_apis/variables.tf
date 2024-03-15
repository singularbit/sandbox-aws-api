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
variable "account_id_4_chars" {
  description = "The last 4 characters of account ID"
  type        = string
  default     = ""
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - CODESTARCONNECTION
# ---------------------------------------------------------------------------------------------------------------------
variable "codestar_connection_arn" {
  description = "CodeStar Connection Arn"
  type        = string
  default     = ""
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - CI/CD PIPELINE(S)
# ---------------------------------------------------------------------------------------------------------------------
variable "cicd_pipelines" {
  description = "CI/CD Pipelines"
  type        = map(object({
    pipeline_repository_name   = string
    pipeline_repository_branch = string
    codebuild_scripts          = map(any)
    codebuild_compute_type     = string
    codebuild_roles            = list(any)
    codebuild_privileged_mode  = bool
    codebuild_proxy_config     = object({
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
