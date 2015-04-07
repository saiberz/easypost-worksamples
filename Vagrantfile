# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos65-x86_64-20140116"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/" <<
    "releases/download/v6.5.3/centos65-x86_64-20140116.box"

  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    v.customize ["modifyvm", :id, "--memory", "2048"]
    # v.gui = true
  end

  config.vm.synced_folder ".", "/vagrant", nfs: true, nfs_udp: false

  config.ssh.forward_agent = true
  config.vm.hostname = "easypost-worksamples-vm"

  config.vm.provision :shell, :inline => "[[ -s /etc/hostid ]] || dd " <<
    "if=/dev/urandom of=/etc/hostid bs=1 count=4 2>/dev/null"
  config.vm.provision :shell, :path => "bootstrap.sh"

  if Vagrant.has_plugin?("vagrant-hostmanager")
    # this assumes that the private_network is on eth1
    # this should already be available, because the NFS export knows to use
    # this IP even when using dhcp
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      r = "127.127.127.1"
      vm.communicate.execute("/sbin/ip -4 -o addr list dev eth1 | " <<
          "awk -F '[ /]+' '{ print $4 }'") do |type, contents|
        r = contents.split("\n").first if type == :stdout
      end
      r
    end
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.aliases = [
      "easypost-worksamples-vm",
      "easypost-worksamples-vm.local"]
  end

end
