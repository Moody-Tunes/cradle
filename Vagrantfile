# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.define "mtdj" do |mtdj|
    # Configure private network definitions
    mtdj.vm.network "private_network", ip: "192.168.10.21"
    mtdj.vm.hostname = "moodytunes.vm"

    mtdj.ssh.forward_agent = true

    mtdj.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.inventory_path = "inventory/local"
      ansible.raw_arguments = Shellwords.shellsplit(ENV['ANSIBLE_ARGS']) if ENV['ANSIBLE_ARGS']
      ansible.limit = "moodytunes"
    end

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is the path
    # on the guest to mount the folder.
    # For our purposes, we assume that cradle and moodytunes live in the same
    # directory, so we can simply find the host directory by traversing one level up
    mtdj.vm.synced_folder "../moodytunes", "/home/vagrant/moodytunes"
  end

end
