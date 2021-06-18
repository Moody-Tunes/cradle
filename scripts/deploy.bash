#!/bin/bash
set -euo pipefail

# Run ansible against a specified host
# By default will provision the moodytunes host

usage () {
	cat << EOF
usage: bash scripts/deploy.bash [inventory] [playbook]

Run ansible against a specified host. By default will provision the moodytunes host.

inventory: Path to inventory file used in ansible run
playbook: Playbook file to run with ansible
EOF
}

for arg in "$@"
do
    if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]
    then
        usage
        exit 0
    fi
done

INVENTORY=${1:-"inventory/prod_mtdj"}
PLAYBOOK=${2:-"mtdj.yml"}
VAULT_PASSWORD_FILE=".vault_password"

if [ ! "$(command -v ansible-playbook)" ]; then
	echo "ERROR: Could not find ansible-playbook command"
	exit 1
fi

if [ ! -f "$VAULT_PASSWORD_FILE" ]; then
	echo "ERROR: Missing vault password file"
	exit 1
fi

if [ ! -f "$INVENTORY" ]; then
	echo "ERROR: Could not find inventory file $INVENTORY"
	exit 1
fi

if [ ! -f "$PLAYBOOK" ]; then
	echo "ERROR: Could not find playbook file $PLAYBOOK"
	exit 1
fi

echo "Deploying $INVENTORY with playbook $PLAYBOOK"

ansible-playbook \
-i "$INVENTORY" \
--ask-become-pass \
--vault-password-file="$VAULT_PASSWORD_FILE" \
"$PLAYBOOK"
