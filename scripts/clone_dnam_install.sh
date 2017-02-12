#!/bin/bash -

set -o nounset                                                                  # Treat unset variables as an error
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'    # Log
set -x                                                                          # Log
set -e                                                                          # Quit on error

# Example:
# clone_dnam_install.sh qemu+ssh://root@tnm-vm7/system install_test /var/lib/libvirt/images dnam-install

function clone_dnam_install {
    local CONNECTION=${1}
    local DOMAIN=${2}
    local IMAGE_PATH=${3}
    local DOMAIN_CLONE_SOURCE=${4}

    virt-clone \
        --connect ${CONNECTION} \
        --original ${DOMAIN_CLONE_SOURCE} \
        --name ${DOMAIN} \
        --file ${IMAGE_PATH}/${DOMAIN}.qcow2 \
        --debug

    virsh \
        -c ${CONNECTION} \
        start ${DOMAIN}
}