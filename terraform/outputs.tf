## Output the invoke URL
#output "invoke_url" {
#  value = "${aws_api_gateway_deployment.api_gateway_deployment.invoke_url}/${aws_api_gateway_resource.api_gateway_resource.path_part}"
#}

#output "apis" {
#  value = module.apis[*]
#}

#output "cicd_pipelines_4_apis" {
#    value = module.cicd_pipelines_4_apis[*]
#}
