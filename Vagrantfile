Vagrant.configure("2") do |config|

  config.vm.synced_folder ".", "/vagrant"
  config.ssh.forward_x11 = true

  config.vm.define "prod" do |d|
    d.vm.box = "centos/7"
    d.vm.network "private_network", ip: "10.100.198.110"

    d.vm.provision :shell, path: "scripts/bootstrap_ansible.sh"
    d.vm.provision :shell,
        inline: 'PYTHONUNBUFFERED=1 ansible-playbook -vvv  \
            /vagrant/ansible/prod.yml -c local'
    d.vm.provider "virtualbox" do |v|
          v.memory = 2048
    end
  end  

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
    config.vbguest.no_install = false
    config.vbguest.no_remote = true
  end

  config.vm.box_check_update = false
end
