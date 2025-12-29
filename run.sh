#!/bin/bash
cd /tmp

# Check if CodeDeploy environment file exists
ENV_FILE="./codedeploy_env.sh"

if [ -f "$ENV_FILE" ]; then
    echo "Sourcing CodeDeploy environment variables from $ENV_FILE..."
    source "$ENV_FILE"
else
    echo "No CodeDeploy environment file found at $ENV_FILE"
fi

pip install -r requirements.txt
nohup python3 app.py > app.log 2>&1 &
