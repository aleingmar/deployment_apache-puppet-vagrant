Vagrant.configure("2") do |config|
  # Define el so base de la MV
  config.vm.box = "ubuntu/bionic64" 

  # Reenvío de puertos para acceder a Apache (pto 80) en el puerto 8080 en tu máquina anfitriona (Windows)
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Script para instalar Puppet en la máquina virtual
  config.vm.provision "shell", inline: <<-SHELL
    if ! command -v puppet &> /dev/null; then
      sudo apt update
      sudo apt install -y puppet
    fi
  SHELL

  # Configura Puppet para aprovisionar Apache
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "apache.pp" # site.pp, fichero donde se declara la configuración de Puppet
  end
end