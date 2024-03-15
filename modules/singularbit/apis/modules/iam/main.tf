# IAM role for the Lambda function
resource "aws_iam_role" "lambda_execution_role" {

  name = "${var.project_name}-${var.key}-lambda-execution-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = var.custom_tags
}

# Attach the AWSLambdaBasicExecutionRole policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {

  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}