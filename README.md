# SBIT Sandbox AWS API

## OVERVIEW

This script deploys Lambdas behind respective API Gateways via CICD pipelines.
This project was built with Terraform, and bootstrapped by CloudFormation, automated via shell scripts.
It's meant as prof of concept.

## PREREQUISITES

Because you need a Codestar connection, you need to copy this code to your own repository. 

Edit the file "terraform/terraform.XXXX.tfvars" and replace the placeholders with your own values.
Rename the 4 Xs with the last 4 digits of the AWS Account ID you're deploying to.

## HOW-TO USE

The Terraform bootstrap requires executing two scripts which will both create the remote tf state file,
the S3 Bucket that contains it, a DynamoDB table and a KMS key. 

Both scripts allow as argument: create/update/delete

Before running any of the scripts,
make sure you have an active AWS profile to the right account with the right permissions.

Also edit all "cloudformation/*_template.json" files and change them to your needs.

1. Start by creating the Terraform requirements:
```bash
cd cloudformation
tf_state.sh create
```
If all looks good, reply "y" to the prompt.

Allow the CloudFormation script to run and create the resources.

2. Create the pipeline for running the Terraform scripts:
```bash
tf_pipeline.sh create
```
If all looks good, reply "y" to the prompt.

3. Open the AWS Console, and allow your new Codestar connections.

4. Manually release the new pipeline.

5. After the pipeline has run, a new pipeline will have be created which will deploy the Lambdas.

6. Once the CICD pipelines run successfully, you can test the API Gateway(s) via the Console.

### DESTROYING THE INFRASTRUCTURE

1. Open terraform/main.tf and comment everything out. Look at errors about non-empty buckets and empty them. Re-release the pipeline until successful. 
2. cd into cloudformation and run the following commands:
```bash
tf_pipeline.sh delete
```
Reply "y" to the prompt. Again pay attention to bucket(s) that need to be emptied.

3. Delete Terraform bootstrap:
```bash
tf_state.sh delete
```
Reply "y" to the prompt. Again pay attention to bucket(s) that need to be emptied.

