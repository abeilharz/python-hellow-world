#!/bin/bash

echo "You are executing codedeploy lifecycle event hook: $LIFECYCLE_EVENT"
echo

echo "you are in current working directoty :"
pwd
echo

echo "Checking system resources ..."
df -h

echo "checking if python is installed ..."
echo

if command -v python3 &> /dev/null
then
	echo "Python 3 is installed."
	PYTHON_CMD="python3"
elif command -v python &> /dev/null
then
	echo "Python (legacy) is installed."
	PYTHON_CMD="python"
else
	echo "ERROR: Python (python3 or python) is not installed on this server." >&2
	exit 1
fi

echo "cleaning up old files from previous deployments"
cd /tmp
ls app.py  appspec.yml  create-codedeploy-env-vars.sh  pre-install-checks.sh  requirements.txt  run.sh  stop.sh  validate.sh 2> /dev/null
rm -f app.py  appspec.yml  create-codedeploy-env-vars.sh codedeploy_env.sh  pre-install-checks.sh  requirements.txt  run.sh  stop.sh  validate.sh get-codedeploy-config.sh nohup.out 2> /dev/null

echo "Python check complete."
echo
