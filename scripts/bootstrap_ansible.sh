#!/bin/bash

set -e

echo "Installing Ansible..."
sudo yum -y install epel-release
sudo yum -y update
sudo yum -y -d 10 install ansible
sudo yum -y install wget

cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg

# For local ip network testing. Simple web page on port 80
sudo yum -y install httpd
sudo systemctl start httpd

# Fix problem with lost fixed ip address
# https://github.com/mitchellh/vagrant/issues/6235
sudo nmcli connection reload
sudo systemctl restart network.service

