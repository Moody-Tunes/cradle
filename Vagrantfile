# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # Create ssh config file for Vagrant managed machines and add to
  # local ~/.ssh directory
  config.trigger.after :up do |trigger|
    trigger.info = "Adding Vagrant managed machines SSH config to ~/.ssh/vagrant_config"
    trigger.run = {path: "scripts/vagrant_ssh_config.bash"}
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]  # Disable virtualbox logging
  end

  config.vm.define "mtdj" do |mtdj|
    # Configure private network definitions
    mtdj.vm.network "private_network", ip: "192.168.10.21"
    mtdj.vm.hostname = "moodytunes.vm"

    # Set up subdomains and www. prefixed domain names as aliases to host
    mtdj.hostmanager.aliases = [
      "admin.moodytunes.vm",
      "www.moodytunes.vm",
    ]

    mtdj.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end

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

  config.vm.define "elk" do |elk|
    elk.vm.network "private_network", ip: "192.168.10.22"
    elk.vm.hostname = "moodytunes-elk.vm"

    elk.ssh.forward_agent = true

    elk.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.cpus = 1
    end

    elk.vm.provision "ansible" do |ansible|
      ansible.playbook = "elk.yml"
      ansible.inventory_path = "inventory/local_elk"
      ansible.raw_arguments = Shellwords.shellsplit(ENV['ANSIBLE_ARGS']) if ENV['ANSIBLE_ARGS']
      ansible.limit = "moodytunes-elk"
    end
  end

  config.vm.define "db" do |db|
    db.vm.network "private_network", ip: "192.168.10.23"
    db.vm.hostname = "moodytunes-db.vm"

    db.ssh.forward_agent = true

    db.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end

    db.vm.provision "ansible" do |ansible|
      ansible.playbook = "db.yml"
      ansible.inventory_path = "inventory/local_db"
      ansible.raw_arguments = Shellwords.shellsplit(ENV['ANSIBLE_ARGS']) if ENV['ANSIBLE_ARGS']
      ansible.limit = "moodytunes-db"
    end
  end
end
