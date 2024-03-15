{
  "Version": "2012-10-17",
  "Statement": [
%{ for v in roles }
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "${v}"
    },
%{ endfor }
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "ecr:*",
        "codestar-connections:*"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "arn:aws:codebuild:${region}:${account_id}:report-group/*"
      ],
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:BatchPutTestCases",
        "codebuild:UpdateReport"
      ]
    },
%{ if codebuild_private_vpc_id != "" }
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": "*"
    },
%{ endif }
    {
      "Effect": "Allow",
      "Resource": [
        "${codepipeline_artifact_bucket}",
        "${codepipeline_artifact_bucket}/*"
      ],
      "Action": [
        "s3:*"
      ]
    }
  ]
}