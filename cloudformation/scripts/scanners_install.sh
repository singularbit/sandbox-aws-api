#!/bin/bash

if [ "$RUN_TESTS" = true ]; then

  echo "Install tfsec..."
  curl -Lso tfsec https://github.com/aquasecurity/tfsec/releases/download/${TFSEC_VERSION}/tfsec-linux-amd64
  chmod +x tfsec
  sudo mv tfsec /usr/local/bin/tfsec
  tfsec --version

  echo "Install tflint..."
  curl -Lso tflint_linux_amd64.zip https://github.com/terraform-linters/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip
  unzip tflint_linux_amd64.zip
  chmod +x tflint
  sudo mv tflint /usr/local/bin/tflint
  tflint --version

  echo "Install checkov..."
  pip install checkov
  checkov --versio

fi