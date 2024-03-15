#!/bin/bash

# Current Git Branch
Branch=$(git rev-parse --abbrev-ref HEAD)


# Static Variables
#StackName="labsawss3website-tfstate-$Branch" # Too long - Causes Max Length Errors
StackName="labsapi-tfstate-$Branch"


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


# Update the JSON file with the AWS Account ID
rm ./tf_state.$AWS_Account_ID_4_Chars.json 2> /dev/null
rm ./tf_state_tags_.$AWS_Account_ID_4_Chars.json 2> /dev/null
cp ./tf_state_template.json ./tf_state.$AWS_Account_ID_4_Chars.json
cp ./tf_state_tags_template.json ./tf_state_tags.$AWS_Account_ID_4_Chars.json
sed -i "s/<BRANCH>/$Branch/g" ./tf_state.$AWS_Account_ID_4_Chars.json
sed -i "s/<ACCOUNT_ID_4_CHARS>/$AWS_Account_ID_4_Chars/g" ./tf_state.$AWS_Account_ID_4_Chars.json
sed -i "s/<BRANCH>/$Branch/g" ./tf_state_tags.$AWS_Account_ID_4_Chars.json
if [ $? -ne 0 ]; then
  echo "Error: Unable update the JSON file!"
  exit 1
else
  echo "JSON file updated successfully!"
  cat ./tf_state.$AWS_Account_ID_4_Chars.json
  cat ./tf_state_tags.$AWS_Account_ID_4_Chars.json
fi


# Update the JSON file with the StackNameOfState
rm ./tf_pipeline.$AWS_Account_ID_4_Chars.json 2> /dev/null
rm ./tf_pipeline_tags.$AWS_Account_ID_4_Chars.json 2> /dev/null
cp ./tf_pipeline_template.json ./tf_pipeline.$AWS_Account_ID_4_Chars.json
cp ./tf_pipeline_tags_template.json ./tf_pipeline_tags.$AWS_Account_ID_4_Chars.json
sed -i "s/<BRANCH>/$Branch/g" ./tf_pipeline.$AWS_Account_ID_4_Chars.json
sed -i "s/<STACK_NAME_OF_STATE>/$StackName/g" ./tf_pipeline.$AWS_Account_ID_4_Chars.json
sed -i "s/<ACCOUNT_ID_4_CHARS>/$AWS_Account_ID_4_Chars/g" ./tf_pipeline.$AWS_Account_ID_4_Chars.json
sed -i "s/<BRANCH>/$Branch/g" ./tf_pipeline_tags.$AWS_Account_ID_4_Chars.json
if [ $? -ne 0 ]; then
  echo "Error: Unable update the JSON file!"
  exit 1
else
  echo "JSON file updated successfully!"
  cat ./tf_pipeline.$AWS_Account_ID_4_Chars.json
  cat ./tf_pipeline_tags.$AWS_Account_ID_4_Chars.json
fi


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
                --template-body file://tf_state.yaml \
                --parameters file://tf_state.$AWS_Account_ID_4_Chars.json \
                --tags file://tf_state_tags.$AWS_Account_ID_4_Chars.json \
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
                --template-body file://tf_state.yaml \
                --parameters file://tf_state.$AWS_Account_ID_4_Chars.json \
                --tags file://tf_state_tags.$AWS_Account_ID_4_Chars.json \
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