#!/bin/bash
# Echo and persist CodeDeploy metadata to a file

# File to store environment variables
ENV_FILE="/tmp/codedeploy_env.sh"

echo "Writing CodeDeploy metadata to $ENV_FILE..."

cat <<EOF > "$ENV_FILE"
export AWS_DEPLOYMENT_ID="$DEPLOYMENT_ID"
export AWS_APPLICATION_NAME="$APPLICATION_NAME"
export AWS_DEPLOYMENT_GROUP_NAME="$DEPLOYMENT_GROUP_NAME"
export AWS_DEPLOYMENT_GROUP_ID="$DEPLOYMENT_GROUP_ID"
export AWS_LIFECYCLE_EVENT="$LIFECYCLE_EVENT"

# Optional: additional metadata
export AWS_REGION="\$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)"
export AWS_INSTANCE_ID="\$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
EOF

# Make the file readable
chmod 755 "$ENV_FILE"

# Print to stdout for logging
echo "--------------------------------------------------"
echo "CodeDeploy Deployment Metadata"
echo "Lifecycle Event: $LIFECYCLE_EVENT"
echo "Deployment ID: $DEPLOYMENT_ID"
echo "Application Name: $APPLICATION_NAME"
echo "Deployment Group Name: $DEPLOYMENT_GROUP_NAME"
echo "Deployment Group ID: $DEPLOYMENT_GROUP_ID"
echo "EC2 Region: \$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)"
echo "EC2 Instance ID: \$(curl -s http://169.254.169.254/latest/meta-data/instance-id)"
echo "--------------------------------------------------"

echo "CodeDeploy metadata saved to $ENV_FILE"

