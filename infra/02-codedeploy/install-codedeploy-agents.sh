#!/bin/bash
set -euo pipefail

# Usage: ./install_codedeploy.sh <AWS_REGION>

REGION="$1"

echo "=== Installing AWS CodeDeploy Agent ==="

sudo dnf install -y ruby wget unzip

echo "Downloading CodeDeploy agent RPM..."
wget -q "https://aws-codedeploy-$REGION.s3.$REGION.amazonaws.com/latest/codedeploy-agent.noarch.rpm" -O codedeploy-agent.rpm

echo "Installing RPM..."
sudo rpm -Uvh codedeploy-agent.rpm >/dev/null 2>&1 || sudo rpm -i codedeploy-agent.rpm

echo "Enabling & starting service"
sudo systemctl enable codedeploy-agent >/dev/null 2>&1 || true
sudo systemctl start codedeploy-agent

echo "Checking status..."
sudo systemctl status codedeploy-agent --no-pager

echo "CodeDeploy agent installed"

