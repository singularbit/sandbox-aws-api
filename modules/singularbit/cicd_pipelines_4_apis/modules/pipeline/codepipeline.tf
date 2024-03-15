locals {
  environment_variables = jsonencode([
    {
      name  = "AWS_ACCOUNT"
      value = data.aws_caller_identity.current.account_id
    },
    {
      name  = "AWS_REGION"
      value = data.aws_region.current.name
    },
    {
      name  = "BRANCH"
      value = var.repository_branch
    },
    {
      name  = "PROJECT"
      value = var.project_name
    },
    {
      name  = "KEY"
      value = var.key
    },    {
      name  = "FILENAME"
      value = var.lambda_filename
    },
  ])
}

resource "aws_codepipeline" "codepipeline" {
  name     = "${var.project_name}-${var.key}"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.s3_bucket_codepipeline_artifacts
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source-${var.project_name}-${var.key}"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = var.codestar_connection_arn
        FullRepositoryId     = var.repository_name
        BranchName           = var.repository_branch
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build_Lambda"

    action {
      name             = aws_codebuild_project.codebuild_deployment["build"].name
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      run_order        = 1
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName          = aws_codebuild_project.codebuild_deployment["build"].name
        EnvironmentVariables = local.environment_variables
      }
    }
  }

  stage {
    name = "Wait_For_Approval"

    action {
      name      = "ApprovalAction"
      category  = "Approval"
      owner     = "AWS"
      provider  = "Manual"
      version   = "1"
      run_order = 2
    }
  }

  stage {
    name = "Deploy_Lambda"

    action {
      name            = aws_codebuild_project.codebuild_deployment["deploy"].name
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 3
      input_artifacts = ["build_output"]

      configuration = {
        ProjectName          = aws_codebuild_project.codebuild_deployment["deploy"].name
        EnvironmentVariables = local.environment_variables
      }
    }
  }

}