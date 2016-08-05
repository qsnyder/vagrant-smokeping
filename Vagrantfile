# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "public_network", bridge: "eth0"

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
 
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "smokeping.yml"

  config.vm.provision "shell", path: "script.sh"

  end
end
