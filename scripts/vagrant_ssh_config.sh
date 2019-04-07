#!/bin/bash

# Add the SSH config for machines managed by Ansible to host SSH directory
# To use this config file, specify the path of the file with -F to ssh
# ssh -F ~/.ssh/vagrant_config mtdj

vagrant ssh-config > ~/.ssh/vagrant_config
