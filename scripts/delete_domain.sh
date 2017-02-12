#!/usr/bin/env bash

set -o nounset                                                                  # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'    # Log
set -x                                                                          # Log
#set -e                                                                          # Quit on error

function delete_domain {
    local HOST="tnm-vm7"                                      # Host where hypervisor runs and where images are stored
    local CONNECTION="qemu+ssh://root@${HOST}/system"         # Connection to remote hypervisor
    local DOMAIN=${1}                                         # The domain name of host where dnam will be installed
    local IMAGE_PATH=${2}

    # Can we run multiple virsh commands on the same line?
    virsh -c ${CONNECTION} destroy ${DOMAIN}
    virsh -c ${CONNECTION} undefine ${DOMAIN}
    ssh "root@${HOST}" "rm -rf ${IMAGE_PATH}/${DOMAIN}.qcow2"
}

delete_domain saturnus /var/lib/libvirt/images