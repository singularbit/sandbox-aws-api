# API Gateway REST API
resource "aws_api_gateway_rest_api" "api_gateway_rest_api" {
  name = "${var.project_name}-${var.key}"
}

# API Gateway Resource
resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_rest_api.root_resource_id
  path_part   = "example"
}

# API Gateway Method
resource "aws_api_gateway_method" "example_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest_api.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method   = var.http_method #"GET"
  authorization = var.authorization #"NONE"
}

# API Gateway Integration
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id
  resource_id = aws_api_gateway_resource.api_gateway_resource.id
  http_method = aws_api_gateway_method.example_method.http_method

  integration_http_method = var.integration_http_method #"POST"
  type                    = var.type #"AWS_PROXY"
  uri                     = var.lambda_invoke_arn
}

# Lambda Permission to allow API Gateway to invoke the function
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"

  # The ARN of the API Gateway method/execution. Use '*' to allow any method.
  source_arn = "${aws_api_gateway_rest_api.api_gateway_rest_api.execution_arn}/*/*/*"
}

# Deploy API
resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest_api.id

  # Trigger a new deployment on configuration changes
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_integration.lambda_integration))
  }

  lifecycle {
    create_before_destroy = true
  }
}