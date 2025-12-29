#!/bin/sh

# Since will be running flask python, need to open up port 5000 on EC2 AL2023 Linux firewall 
# in order to see application via public IP
echo "Adding port 5000 in Linux O.S Firewall in order to reach flask app via public EC2 IP"
sudo firewall-cmd --list-all
sudo firewall-cmd --add-port=5000/tcp --permanent
sudo firewall-cmd --reload
