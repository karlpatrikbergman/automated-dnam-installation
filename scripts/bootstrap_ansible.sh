#!/bin/bash

# This file is only used with Vagrant, not with libvirt

set -o nounset                                                                  # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'    # Log
set -x                                                                          # Log
set -e                                                                          # Quit on error

echo "Installing Ansible..."
sudo yum -y install epel-release
sudo yum -y update
sudo yum -y -d 10 install ansible
sudo yum -y install wget

cp /vagrant/ansible/ansible.cfg /etc/ansible/ansible.cfg
cp /vagrant/files/CentOS7-local.repo /etc/yum.repos.d/CentOS7-local.repo


# For local ip network testing. Simple web page on port 80
sudo yum -y install httpd
sudo systemctl start httpd

# Fix problem with lost fixed ip address
# https://github.com/mitchellh/vagrant/issues/6235
sudo nmcli connection reload
sudo systemctl restart network.service

