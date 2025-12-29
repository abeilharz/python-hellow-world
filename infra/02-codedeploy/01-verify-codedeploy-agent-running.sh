#!/bin/bash

# Usage: 01-verify-codedeploy-running.sh [REGION]

DEFAULT_REGION="eu-west-2"
INSTALL_SCRIPT="./install-codedeploy-agents.sh"

REGION="${1:-$DEFAULT_REGION}"

echo "Checking for AWS CodeDeploy Agent on Amazon Linux 2023..."
echo "--------------------------------------------------------"

# 1. Check if codedeploy-agent binary exists
if ! command -v codedeploy-agent >/dev/null 2>&1; then
    echo "CodeDeploy agent is NOT installed."

    # Check if install script exists
    if [ ! -f "$INSTALL_SCRIPT" ]; then
        echo "Install script not found: $INSTALL_SCRIPT"
        exit 1
    fi

    echo "Running install script: $INSTALL_SCRIPT $REGION"
    bash "$INSTALL_SCRIPT" "$REGION"

else
    echo "CodeDeploy agent binary found."
fi

# 2. Check systemd service
if systemctl list-unit-files | grep -q codedeploy-agent.service; then
    echo "CodeDeploy service is installed."
else
    echo "CodeDeploy service is NOT registered with systemd."
    exit 1
fi

# 3. Check if running
if systemctl is-active --quiet codedeploy-agent; then
    echo "CodeDeploy agent is RUNNING."
else
    echo "CodeDeploy agent is installed but NOT running. Starting it..."
    sudo systemctl start codedeploy-agent

    if systemctl is-active --quiet codedeploy-agent; then
        echo "CodeDeploy agent started."
    else
        echo "Failed to start CodeDeploy agent."
        exit 1
    fi
fi

echo "Done."
