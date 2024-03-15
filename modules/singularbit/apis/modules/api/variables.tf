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
# VARIABLES - API
# ---------------------------------------------------------------------------------------------------------------------
variable "key" {
  description = "The key of the static website to use"
  type        = string
  default     = ""
}


# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES - API
# ---------------------------------------------------------------------------------------------------------------------
variable "lambda_invoke_arn" {
  description = "The ARN of the Lambda function to use"
  type        = string
  default     = ""
}
variable "lambda_name" {
  description = "The name of the Lambda function to use"
  type        = string
  default     = ""
}
variable "http_method" {
  description = "The HTTP method for the integration"
  type        = string
  default     = ""
}
variable "authorization" {
  description = "The authorization method for the integration"
  type        = string
  default     = ""
}
variable "integration_http_method" {
  description = "The HTTP method for the integration"
  type        = string
  default     = ""
}
variable "type" {
  description = "The type of the integration"
  type        = string
  default     = ""
}

