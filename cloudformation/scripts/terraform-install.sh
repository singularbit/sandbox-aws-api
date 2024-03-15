#!/bin/bash

set -e

echo "Installing Terraform..."
cd /tmp
curl -s -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && mv terraform /usr/bin/
terraform --version

echo "Installing Terratest..."
curl --location --silent --fail --show-error -o terratest_log_parser https://github.com/gruntwork-io/terratest/releases/download/${TERRATEST_VERSION}/terratest_log_parser_linux_amd64
chmod +x terratest_log_parser
mv terratest_log_parser /usr/bin/
terratest_log_parser --version

cd -


