#!/bin/bash

# Add the SSH config for machines managed by Ansible to host SSH directory
# To use this config file, specify the path of the file with the -F option to ssh
# ssh -F ~/.ssh/vagrant_config mtdj

VAGRANT_SSH_CONFIG="$HOME/.ssh/vagrant_config"

if [ -f "$VAGRANT_SSH_CONFIG" ]; then
	rm -f "$VAGRANT_SSH_CONFIG"
fi

touch "$VAGRANT_SSH_CONFIG"

{
	echo "###This file is automatically managed by Vagrant###"

	# mtdj
	vagrant ssh-config --host moodytunes.vm mtdj 2>/dev/null

	# elk
	vagrant ssh-config --host moodytunes-elk.vm elk 2>/dev/null

	echo "###End Vagrant managed file###"
} >> "$VAGRANT_SSH_CONFIG"
