#!/bin/bash

# ansible command to deploy production application

INVENTORY="inventory/prod"
VAULT_PASSWORD_FILE=".vault_password"

ansible-playbook \
-i $INVENTORY \
--ask-become-pass \
--vault-password-file=$VAULT_PASSWORD_FILE \
site.yml
