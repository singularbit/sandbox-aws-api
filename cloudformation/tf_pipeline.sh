#!/bin/bash

# Current Git Branch
Branch=$(git rev-parse --abbrev-ref HEAD)


# Static Variables
#StackName="labsawss3website-tfpipeline-$Branch" # Too long - Causes Max Length Errors
StackName="labsapi-tfpipeline-$Branch"


# Get the AWS Account ID
AWS_Account_ID=$(aws sts get-caller-identity --query "Account" --output text)
AWS_Account_ID_4_Chars="${AWS_Account_ID: -4}"
if [ $? -ne 0 ]; then
  echo "Error: Unable to lookup account id!"
  exit 1
else
  echo "AWS Account ID (Last 4 chars): $AWS_Account_ID_4_Chars"
fi


# Get the AWS Region
AWS_Region=$(aws configure get region)
if [ $? -ne 0 ]; then
  echo "Error: Unable to lookup region!"
  exit 1
else
  echo "AWS Region: $AWS_Region"
fi

cat ./tf_pipeline.$AWS_Account_ID_4_Chars.json
cat ./tf_pipeline_tags.$AWS_Account_ID_4_Chars.json

# Execute commands
echo
if [ -z "$1" ]
  then
    echo "No argument supplied"
    aws cloudformation describe-stacks --stack-name $StackName | grep -i StackStatus
else
  if [ "$1" == "create" ]
    then
      echo "Creating Cloudformation stack..."
      while true; do
          read -p "Do you wish to create this stack? " yn
          case $yn in
              [Yy]* )
                aws cloudformation create-stack \
                --stack-name $StackName \
                --template-body file://tf_pipeline.yaml \
                --parameters file://tf_pipeline.$AWS_Account_ID_4_Chars.json \
                --tags file://tf_pipeline_tags.$AWS_Account_ID_4_Chars.json \
                --region $AWS_Region \
                --capabilities CAPABILITY_IAM;
                break;;
              [Nn]* ) exit;;
              * ) echo "Please answer yes or no.";;
          esac
      done
  elif [ "$1" == "update" ]
    then
      echo "Updating Cloudformation stack..."
      while true; do
          read -p "Do you wish to update this stack? " yn
          case $yn in
              [Yy]* )
                aws cloudformation update-stack \
                --stack-name $StackName \
                --template-body file://tf_pipeline.yaml \
                --parameters file://tf_pipeline.$AWS_Account_ID_4_Chars.json \
                --tags file://tf_pipeline_tags.$AWS_Account_ID_4_Chars.json \
                --region $AWS_Region \
                --capabilities CAPABILITY_IAM;
                 break;;
              [Nn]* ) exit;;
              * ) echo "Please answer yes or no.";;
          esac
      done
  elif [ "$1" == "delete" ]
    then
      echo "Deleting Cloudformation stack..."
      while true; do
          read -p "Do you wish to delete this stack? " yn
          case $yn in
              [Yy]* )
                aws cloudformation delete-stack \
                --region $AWS_Region \
                --stack-name $StackName;
                 break;;
              [Nn]* ) exit;;
              * ) echo "Please answer yes or no.";;
          esac
      done
  else
    echo "Invalid argument supplied"
  fi
fi