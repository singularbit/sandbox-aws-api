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
variable "role" {
    description = "The role to be assumed by the function"
    type        = string
}
variable "handler" {
    description = "The entrypoint of the function"
    type        = string
}
variable "runtime" {
    description = "The runtime of the function"
    type        = string
}
variable "filename" {
    description = "The filename of the function"
    type        = string
}
