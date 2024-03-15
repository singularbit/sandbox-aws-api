# ---------------------------------------------------------------------------------------------------------------------
# IAM ROLES AND POLICIES - CODEPIPELINE
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.project_name}-${var.key}-cp-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = var.custom_tags
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.project_name}-${var.key}-cp-policy"
  role = aws_iam_role.codepipeline_role.id

  policy = templatefile(
    "${path.module}/templates/codepipeline_policy.json.tpl",
    {
      codepipeline_bucket_arn = var.s3_arn_codepipeline_artifacts
    }
  )
}

resource "aws_iam_role_policy_attachment" "codepipeline_codecommit" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}


# ---------------------------------------------------------------------------------------------------------------------
# IAM ROLES AND POLICIES - CODEBUILD
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "codebuild_role" {
  name = "${var.project_name}-${var.key}-cb-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${var.project_name}-${var.key}-cb-policy"
  role = aws_iam_role.codebuild_role.name

  policy = templatefile(
    "${path.module}/templates/codebuild_policy.json.tpl",
    {
      roles                        = var.codebuild_roles #Cross Account Roles
      codepipeline_artifact_bucket = var.s3_arn_codepipeline_artifacts
      codebuild_private_vpc_id     = var.codebuild_private_vpc_config["vpc_id"]
      account_id                   = data.aws_caller_identity.current.account_id
#      region                       = var.static_website_region
      region                       = data.aws_region.current.name
    }
  )
}

resource "aws_iam_role_policy_attachment" "codebuild_codecommit" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitReadOnly"
}

resource "aws_iam_role_policy_attachment" "codebuild_deploy" {
  count      = var.codebuild_roles == tolist([]) ? 1 : 0
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}