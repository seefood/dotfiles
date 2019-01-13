# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

$script = <<-SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
#chmod 400 ~vagrant/.ssh/id_rsa
echo "nameserver 1.1.1.1" > /etc/hosts
echo "Now ssh to the vagrant machine and run /dotfiles/bootstrap.sh && \
~vagrant/.homesick/repos/dotfiles/install_bash_it.sh && \
~vagrant/.homesick/repos/dotfiles/install_general.sh && \
~vagrant/.homesick/repos/dotfiles/install_dev.sh"
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # See box list
  #   http://www.vagrantbox.es/
  config.vm.box = "generic/ubuntu1804"
  # config.vm.box = "generic/ubuntu1604"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "https://github.com/jose-lpa/packer-ubuntu_lts/releases/download/v3.1/ubuntu-16.04.box"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.42.42"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/dotfiles"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    #   vb.gui = true

    # Enable creating symlinks between guest and host
    vb.customize [
      # see https://github.com/mitchellh/vagrant/issues/713#issuecomment-17296765
      # 1) Added these lines to my config :
      #
      # 2) run this command in an admin command prompt on windows :
      #    >> fsutil behavior set SymlinkEvaluation L2L:1 R2R:1 L2R:1 R2L:1
      #    see http://technet.microsoft.com/ja-jp/library/cc785435%28v=ws.10%29.aspx
      # 3) REBOOT HOST MACHINE
      # 4) 'vagrant up' from an admin command prompt
      "setextradata", :id,
      "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"
    ]

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize [
      'modifyvm', :id,
      '--natdnshostresolver1', 'on',
      '--memory', '1024',
      '--cpus', '2'
    ]
  end

  config.vm.provision "file", source: "~ira/.ssh/id_rsa", destination: "~vagrant/.ssh/id_rsa"
  config.vm.provision "file", source: "~ira/.netrc", destination: "~vagrant/.netrc"

  config.vm.provision "shell", inline: $script

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  # config.vm.provision "chef_solo" do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision "chef_client" do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
