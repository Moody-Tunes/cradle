#!/bin/bash

# ansible command to deploy production application

INVENTORY="inventory/prod"
VAULT_PASSWORD_FILE=".vault_password"

if [ ! -f "$VAULT_PASSWORD_FILE" ]; then
	echo "ERROR: Missing vault password file"
	exit 1
fi

ansible-playbook \
-i "$INVENTORY" \
--ask-become-pass \
--vault-password-file="$VAULT_PASSWORD_FILE" \
site.yml
