#!/usr/bin/env bash

set -o nounset                                                                  # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'    # Log
set -x                                                                          # Log
set -e                                                                          # Quit on error

source scripts/clone_dnam_install.sh
source scripts/get_domain_ip_address.sh

# TODO:
# - Rename clone source file to "dnam-install-clone-from"
# - Move this functionality to ansible role

DOMAIN_CLONE_SOURCE="dnam-install"                  # An domain (not running) on tnm-vm7
CONNECTION="qemu+ssh://root@tnm-vm7/system"         # Connection to remote hypervisor
DOMAIN=${1}                                         # The domain name of host where dnam will be installed

# Clone a new vm
clone_dnam_install ${CONNECTION} ${DOMAIN} /var/lib/libvirt/images ${DOMAIN_CLONE_SOURCE}

# TODO: Verify vm is up and running instead of sleeping
sleep 10

# TODO: Try for some iterations before continuing
INSTALL_HOST_IP="$(get_domain_ip_address ${CONNECTION} ${DOMAIN} 172.16.15.0/24 br0)"
echo "${INSTALL_HOST_IP}"

# TODO: What is default directory for a project like this?
export ANSIBLE_CONFIG=ansible/ansible.cfg

# Write vm ip number to ansible hosts file
# TODO: Do this some yet unknown Ansible way
> ansible/hosts/prod
echo "[prod]" >> ansible/hosts/prod
echo "${INSTALL_HOST_IP}  ansible_connection=ssh ansible_ssh_user=root ansible_ssh_pass=transmode" >> ansible/hosts/prod

sleep 10

# TODO: get {{ host }} variable from inventory instead of passing it twice
ansible-playbook ansible/prod.yml -i ansible/hosts/prod -T 5 --extra-vars "host=${INSTALL_HOST_IP}"
