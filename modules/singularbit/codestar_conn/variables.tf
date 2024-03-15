variable "codestar_connection_name" {
  description = "The name of the connection"
  type        = string
  default     = "my-connection"
}
variable "codestar_connection_provider_type" {
  description = "The type of the provider"
  type        = string
  default     = "GitHub"
}