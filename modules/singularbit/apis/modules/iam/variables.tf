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