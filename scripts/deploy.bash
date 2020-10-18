#!/bin/bash

# ansible command to deploy production application

INVENTORY="inventory/prod_mtdj"
VAULT_PASSWORD_FILE=".vault_password"

if [ ! "$(command -v ansible-playbook)" ]; then
	echo "ERROR: Could not find ansible-playbook command"
	exit 1
fi

if [ ! -f "$VAULT_PASSWORD_FILE" ]; then
	echo "ERROR: Missing vault password file"
	exit 1
fi

ansible-playbook \
-i "$INVENTORY" \
--ask-become-pass \
--vault-password-file="$VAULT_PASSWORD_FILE" \
mtdj.yml
