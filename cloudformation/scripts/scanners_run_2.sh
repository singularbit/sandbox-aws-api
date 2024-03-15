#!/bin/bash

if [ "$RUN_TESTS" = true ]; then

  #echo "Running snyk..."
  #snyk iac test tf-plan.json --severity-threshold=critical

  echo "Running tfsec..."
  tfsec --no-colour --format json --tfvars-file terraform.tfvars | tee tfsec-out.json
  cat tfsec-out.json | jq -r '.results[] | select(.severity == "CRITICAL") | .rule_id' | tee tfsec-critical.txt

  # reference: https://www.checkov.io/7.Scan%20Examples/Terraform%20Plan%20Scanning.html
  echo "Running checkov..."
  checkov --quiet --soft-fail -f tfplan.json

fi