resource "aws_codestarconnections_connection" "codestarconnections_connection" {
  name          = var.codestar_connection_name
  provider_type = var.codestar_connection_provider_type
}