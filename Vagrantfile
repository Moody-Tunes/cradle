# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ] # Disable logging for virtual machine
    vb.memory = 2048
    vb.cpus = 1
  end

  # Create ssh config file for Vagrant managed machines and add to
  # local ~/.ssh directory
  config.trigger.after :up do |trigger|
    trigger.info = "Adding Vagrant managed machines SSH config to ~/.ssh/vagrant_config"
    trigger.run = {path: "scripts/vagrant_ssh_config.sh"}
  end

  config.vm.define "mtdj" do |mtdj|
    # Configure private network definitions
    mtdj.vm.network "private_network", ip: "192.168.10.21"
    mtdj.vm.hostname = "moodytunes.vm"

    # Set up subdomains and www. prefixed domain names as aliases to host
    config.hostsupdater.aliases = [
      "admin.moodytunes.vm",
      "www.moodytunes.vm",
    ]

    mtdj.ssh.forward_agent = true

    mtdj.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.inventory_path = "inventory/local"
      ansible.raw_arguments = Shellwords.shellsplit(ENV['ANSIBLE_ARGS']) if ENV['ANSIBLE_ARGS']
      ansible.limit = "moodytunes"
    end

    # Share an additional directory to the VM. This will sync changes made on the
    # host machine to the VM automatically, so you can edit code on your host
    # without having to fuss about on your VM.
    #
    # The first argument is the path to the host directory to sync, the second
    # is the path on the VM to mount the directory. We assume that cradle
    # and moodytunes are stored on the same host folder following the install guide,
    # so we can look one level up to find the moodytunes directory on the host machine.
    #
    # NOTE: The guest sync folder MUST correspond to the `repository_path` variable set
    # in ansible to ensure that the changes made locally are synced to the correct
    # directory on the VM.
    mtdj.vm.synced_folder "../moodytunes", "/srv/mtdj/moodytunes"
  end

end
