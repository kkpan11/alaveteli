# This Vagrantfile should be used with the --no-color option, e.g.
#   vagrant --no-color up
#
# Then you should be able to visit the site at:
#   http://alaveteli.10.10.10.30.xip.io
#
# You can customise the FQDN in your environment
#   export ALAVETELI_VAGRANT_FQDN=alaveteli.dev
#
# Customisation Options
# =====================
ALAVETELI_FQDN = ENV['ALAVETELI_VAGRANT_FQDN'] || "alaveteli.10.10.10.30.xip.io"
ALAVETELI_MEMORY = ENV['ALAVETELI_VAGRANT_MEMORY'] || 1536

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :private_network, :ip => "10.10.10.30"
  config.vm.synced_folder ".", "/home/vagrant/alaveteli", :owner => "vagrant", :group => "vagrant"

  config.ssh.forward_agent = true

  # The bundle install fails unless you have quite a large amount of
  # memory; insist on 1.5GiB:
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", ALAVETELI_MEMORY]
  end

  # Fetch and run the install script:
  config.vm.provision :shell, :inline => "wget -O install-site.sh https://raw.github.com/mysociety/commonlib/master/bin/install-site.sh"
  config.vm.provision :shell, :inline => "chmod a+rx install-site.sh"
  config.vm.provision :shell, :inline => "./install-site.sh " \
                                             "--dev " \
                                             "alaveteli " \
                                             "vagrant " \
                                             "#{ ALAVETELI_FQDN }"
end
