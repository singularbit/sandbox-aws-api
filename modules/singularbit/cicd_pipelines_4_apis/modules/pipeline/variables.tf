# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - GLOBAL
# ---------------------------------------------------------------------------------------------------------------------
variable "custom_tags" {
  description = "Custom tags to apply to all resources"
  type        = map(any)
  default     = {}
}

variable "project_name" {
  description = "Project Name"
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
# VARIABLES - CODEPIPELINE
# ---------------------------------------------------------------------------------------------------------------------
variable "key" {
  description = "The key of the static website to use"
  type        = string
  default     = ""
}

variable "repository_name" {
  description = "Repository Name"
  type        = string
  default     = ""
}
variable "repository_branch" {
  description = "Repository Branch"
  type        = string
  default     = ""
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - CODEBUILD
# ---------------------------------------------------------------------------------------------------------------------
variable "codebuild_scripts" {
  description = "Codebuild Scripts"
  type        = map(any)
  default     = {}
}
variable "codebuild_compute_type" {
  description = "The DEFAULT EC2 instance for running CodeBuild"
  type        = string
  default     = ""
}

variable "codebuild_roles" {
  description = "IAM roles to associate to CodeBuild"
  type        = list(any)
  default     = []
}

variable "codebuild_privileged_mode" {
  description = "Enable CodeBuild to use Docker to build images"
  type        = string
  default     = ""
}

variable "codebuild_proxy_config" {
  description = "Proxies used by CodeBuild"
  type        = object({
    HTTP_PROXY  = string
    http_proxy  = string
    HTTPS_PROXY = string
    https_proxy = string
    NO_PROXY    = string
    no_proxy    = string
  })
  default = {
    HTTP_PROXY  = ""
    http_proxy  = ""
    HTTPS_PROXY = ""
    https_proxy = ""
    NO_PROXY    = ""
    no_proxy    = ""
  }
}

variable "codebuild_private_vpc_config" {
  description = "Map of values for private VPC, Subnets and Security Groups"
  type        = object({
    vpc_id             = string
    subnet_ids         = string
    security_group_ids = string
  })
  default = {
    vpc_id             = ""
    subnet_ids         = ""
    security_group_ids = ""
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - LAMBDA
# ---------------------------------------------------------------------------------------------------------------------
variable "lambda_filename" {
  description = "Filename of the Lambda function"
  type        = string
  default     = ""
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - EXTERNAL RESOURCES
# ---------------------------------------------------------------------------------------------------------------------
variable "s3_bucket_codepipeline_artifacts" {
  description = "S3 Bucket for CodePipeline Artifacts"
  type        = string
  default     = ""
}
variable "s3_arn_codepipeline_artifacts" {
  description = "S3 ARN for CodePipeline Artifacts"
  type        = string
  default     = ""
}
variable "codebuild_logs_s3_id" {
  description = "S3 Bucket for CodeBuild Logs"
  type        = string
  default     = ""
}

