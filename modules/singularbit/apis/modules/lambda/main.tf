

#resource "local_file" "config" {
#  content = templatefile("lambda/lambda_function_1.py", {
#    message = "my value"
#  })
#  filename = "${path.module}/lambda/etc/config.json"
#}

#data "archive_file" "lambdazip" {
#  type        = "zip"
##  source_file = "${path.cwd}/lambda/${var.filename}/${var.filename}.py"
##  source_dir = "${path.cwd}/lambda/${var.filename}/"
##  output_path = "${path.cwd}/lambda/${var.filename}.zip"
#  source_dir = "${path.root}/lambda/${var.filename}/"
#  output_path = "${path.root}/lambda/${var.filename}.zip"
#}


resource "null_resource" "zip_lambda_function" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "zip -j ${path.root}/lambda/${var.filename}.zip ${path.root}/lambda/${var.filename}/${var.filename}.py"
  }
}

resource "aws_lambda_function" "lambda_function" {

  depends_on = [
    null_resource.zip_lambda_function
  ]

  function_name = "${var.project_name}-${var.key}"
  role          = var.role
  handler       = var.handler
  runtime       = var.runtime
#  filename      = data.archive_file.lambdazip.output_path
  filename      = "${path.root}/lambda/${var.filename}.zip"
}

### NOTE: Beware of the following when defining the path of the zip file:
/*
│ Error: Provider produced inconsistent final plan
│
│ When expanding the plan for
│ module.apis.module.lambda["pipeline-1"].aws_lambda_function.lambda_function
│ to include new values learned so far during apply, provider
│ "registry.terraform.io/hashicorp/aws" produced an invalid new value for
│ .filename: was
│ cty.StringVal("/codebuild/output/src3752517121/src/terraform/lambda/function-1.zip"),
│ but now
│ cty.StringVal("/codebuild/output/src2388/src/s3/00/terraform/lambda/function-1.zip").
│
│ This is a bug in the provider, which should be reported in the provider's
│ own issue tracker.
╵
*/