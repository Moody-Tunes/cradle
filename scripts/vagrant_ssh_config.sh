#!/bin/bash

# Add the SSH config for machines managed by Ansible to host SSH directory
# To use this config file, specify the path of the file with -F to ssh
# ssh -F ~/.ssh/vagrant_config mtdj

# mtdj
vagrant ssh-config --host moodytunes.vm mtdj > ~/.ssh/vagrant_config
