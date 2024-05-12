# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #Instance qui heberge notre application Java
  config.vm.define "devapp01" do |devapp01|

    devapp01.vm.box = "bento/ubuntu-22.04"

    devapp01.vm.box_check_update = false

    devapp01.vm.network "private_network", type: "static", ip: "172.16.238.10"

    devapp01.vm.provider "virtualbox" do |vb|

      vb.gui = false
      vb.name = "devapp01"
      vb.memory = "1024"
    end
    devapp01.vm.provision "shell", inline: <<-SHELL
      # Installation de Java 17
      sudo apt-get update
      sudo apt-get install -y openjdk-17-jdk
      sudo apt-get install -y default-jdk
      
      # Installation de Tomcat
      sudo apt-get install -y tomcat9
      
      # Installation de Git
      sudo apt-get install -y git
    SHELL
  end

  #Instance avec une base de donnees PostgreSQL
  config.vm.define "dbapp01" do |dbapp01|

    dbapp01.vm.box = "bento/ubuntu-22.04"

    dbapp01.vm.box_check_update = false

    dbapp01.vm.network "private_network", type: "static", ip: "172.16.238.11"

    dbapp01.vm.provider "virtualbox" do |vb|

      vb.gui = true
      vb.name = "dbapp01"
      vb.memory = "1024"
    end
    dbapp01.vm.provision "shell", path: "setup_postgresql.sh"
    dbapp01.vm.provision "shell", inline: <<-SHELL
      sudo -u postgres psql -c "CREATE DATABASE dbapp001;"
    SHELL
    dbapp01.vm.provision "shell", path: "configure_pg_hba.sh"
    dbapp01.vm.provision "shell", inline: <<-SHELL
    sudo systemctl restart postgresql
    SHELL
  end

  #Instance de sauvegarde code source et base de donnees
  config.vm.define "backup01" do |backup01|

    backup01.vm.box = "bento/ubuntu-22.04"

    backup01.vm.box_check_update = false

    backup01.vm.network "private_network", type: "static", ip: "172.16.238.12"

    backup01.vm.provider "virtualbox" do |vb|

      vb.gui = true
      vb.name = "backup01"
      vb.memory = "1024"
    end
  end

end
