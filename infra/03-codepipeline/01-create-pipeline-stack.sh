#!/usr/bin/env bash
set -euo pipefail

STACK_NAME="python-hello-world-cicd-stack"
TEMPLATE_FILE="codepipeline-template.yml"
REGION="eu-west-2"

# Default CFN parameter values
CODEPIPELINE_ROLE_ARN="!!!TODO-ENTER-CODEPIPELINE-IAM-SERVICE-ROLE-ARN!!!"
PIPELINE_BUCKET="!!!TODO-ENTER-S3-BUCKET-NAME!!!"
GIT_CONNECTION_ARN="!!!TODO-ENTER-CODECONNECT-ARN!!!"
# Example: arn:aws:codeconnections:eu-west-2:123456789101:connection/aaaaaaaa-bbbbb-cccc-ddddddddddd"
GIT_FULL_REPO_ID="!!!TODO-ENTER-GITHUB-REPO_ID!!!"
# Example: aws/aws-cli"
GIT_BRANCH="main"
CLOUDFORMATION_EXEC_ROLE_ARN="!!!TODO-ENTER-CFN-IAM-SERVICE-ROLE-ARN!!!"
DEFAULT_APPLICATION_NAME="aws-cicd-python-helloworld"
DEFAULT_DEPLOYMENT_GROUP_NAME="ec2-deployment"

echo "Validating CloudFormation template: $TEMPLATE_FILE"

# Pre-check: validate template
aws cloudformation validate-template \
  --template-body file://"$TEMPLATE_FILE"

echo "Template validation passed. Deploying stack..."

# Deploy stack
aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --capabilities CAPABILITY_NAMED_IAM \
  --region "$REGION" \
  --parameter-overrides \
      CodePipelineRoleArn="$CODEPIPELINE_ROLE_ARN" \
      PipelineBucket="$PIPELINE_BUCKET" \
      GitConnectionArn="$GIT_CONNECTION_ARN" \
      GitFullRepoId="$GIT_FULL_REPO_ID" \
      GitBranch="$GIT_BRANCH" \
      CloudFormationExecutionRoleArn="$CLOUDFORMATION_EXEC_ROLE_ARN" \
      DefaultApplicationName="$DEFAULT_APPLICATION_NAME" \
      DefaultDeploymentGroupName="$DEFAULT_DEPLOYMENT_GROUP_NAME"

echo "Waiting for CloudFormation stack to complete..."

aws cloudformation wait stack-create-complete \
  --stack-name "$STACK_NAME" \
  --region "$REGION"

echo "Stack deployment finished. Outputs:"
aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --region "$REGION" \
  --query "Stacks[0].Outputs"

