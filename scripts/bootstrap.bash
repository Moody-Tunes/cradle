#!/bin/bash
set -euo pipefail

host_ip="$1"


### Create provisioning user
provisioning_user="ansible"

echo "Creating ansible user..."
ssh root@$host_ip 'sudo grep $provisioning_user /etc/passwd > /dev/null 2>&1 || sudo adduser $provisioning_user'
ssh root@$host_ip 'sudo usermod -aG sudo $provisioning_user'
