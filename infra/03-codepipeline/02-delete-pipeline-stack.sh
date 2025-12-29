#!/usr/bin/env bash
set -euo pipefail

# Default values
PIPELINE_STACK="${1:-python-hello-world-cicd-stack}"
CODEBUILD_STACK="${2:-python-hello-world-codebuild-stack}"
CODEDEPLOY_STACK="${3:-python-hello-world-codedeploy-stack}"
REGION="${4:-eu-west-2}"

echo "Deleting CodeBuild stack: $CODEBUILD_STACK"
aws cloudformation delete-stack --stack-name "$CODEBUILD_STACK" --region "$REGION"
aws cloudformation wait stack-delete-complete --stack-name "$CODEBUILD_STACK" --region "$REGION"

echo "Deleting CodeDeploy stack: $CODEDEPLOY_STACK"
aws cloudformation delete-stack --stack-name "$CODEDEPLOY_STACK" --region "$REGION"
aws cloudformation wait stack-delete-complete --stack-name "$CODEDEPLOY_STACK" --region "$REGION"

echo "Deleting parent pipeline stack: $PIPELINE_STACK"
aws cloudformation delete-stack --stack-name "$PIPELINE_STACK" --region "$REGION"
aws cloudformation wait stack-delete-complete --stack-name "$PIPELINE_STACK" --region "$REGION"

echo "All stacks deleted."

