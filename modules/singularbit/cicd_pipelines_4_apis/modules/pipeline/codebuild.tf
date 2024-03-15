resource "aws_codebuild_project" "codebuild_deployment" {

  depends_on = [aws_iam_role.codebuild_role]

  for_each   = var.codebuild_scripts

  name         = "${var.project_name}-${var.key}-${each.key}"
  description  = "CodeBuild Role for ${var.project_name}-${var.key}-${each.key}"

  build_timeout = "120"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE"]
  }

  # TODO: Replace image and image_pull_credentials_type
  environment {
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = var.codebuild_privileged_mode
    compute_type                = var.codebuild_compute_type

    dynamic "environment_variable" {
      for_each = var.codebuild_proxy_config["HTTP_PROXY"] != "" ? var.codebuild_proxy_config : {}
      content {
        name  = environment_variable.key
        value = environment_variable.value
      }
    }
  }

  dynamic "vpc_config" {
    for_each = var.codebuild_private_vpc_config["vpc_id"] != "" ? [var.codebuild_private_vpc_config["vpc_id"]] : []
    content {
      vpc_id              = var.codebuild_private_vpc_config["vpc_id"]
      subnets             = split(",", var.codebuild_private_vpc_config["subnet_ids"])
      security_group_ids  = split(",", var.codebuild_private_vpc_config["security_group_ids"])
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = "${var.project_name}-${var.key}-${each.key}-log-group"
      stream_name = "${var.project_name}-${var.key}-${each.key}log-stream"
    }

    s3_logs {
      status = "ENABLED"
      location = "${var.codebuild_logs_s3_id}/${each.key}/build_logs"
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = each.value
  }

  tags = var.custom_tags
}