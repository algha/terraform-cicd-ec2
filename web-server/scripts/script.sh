#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

sudo yum -y update
sudo yum install -y ruby
cd /home/ec2-user
curl -O https://aws-codedeploy-ap-northeast-1.s3.amazonaws.com/latest/install
sudo chmod +x ./install
sudo ./install auto

# Install stress
# sudo amazon-linux-extras install epel -y
# sudo yum install stress -y
# stress --cpu 2 --timeout 300

# install nginx
# sudo yum -y install nginx

# make sure nginx is started
# service nginx start