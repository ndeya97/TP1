# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #Instance qui heberge notre application Java
  config.vm.define "devapp01" do |devapp01|
    devapp01.vm.box = "bento/ubuntu-22.04"
    devapp01.vm.box_check_update = false
    devapp01.vm.network "private_network", type: "static", ip: "172.16.238.10"
    
    #repertoires de synchronisation entre la machine locale et la vm devapp01 :
    devapp01.vm.synced_folder "./tomcatwebapps", "/opt/tomcat/webapps"
    devapp01.vm.synced_folder "./fintechapp", "/opt/fintechapp"

    devapp01.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "devapp01"
      vb.memory = "1024"
    end

    devapp01.vm.provision "shell", inline: <<-SHELL
      # Installation de Java 17 et default-jdk
      sudo apt-get update
      sudo apt-get install -y openjdk-17-jdk default-jdk  
      # Installation de Tomcat
      sudo apt-get install -y tomcat9 tomcat9-admin
      #Installation d'un postgreSQL client pour acceder a la base de donnees PostgreSQL
      sudo apt-get install -y postgresql-client-14
      # Installation de Git
      sudo apt-get install -y git rsync

      # Configuration de Tomcat
      sudo sed -i 's/.*<Connector port="8080".*/<Connector port="8080" protocol="HTTP\/1.1" connectionTimeout="20000" URIEncoding="UTF-8" \/>/' /etc/tomcat9/server.xml 
      # Redemarrage de Tomcat pour appliquer les changements de configuration
      sudo systemctl restart tomcat9
    SHELL

    # Script de sauvegarde et configuration de cron
    devapp01.vm.provision "shell", path: "backup_code_setup.sh"
  end

  #Instance avec une base de donnees PostgreSQL
  config.vm.define "dbapp01" do |dbapp01|
    dbapp01.vm.box = "bento/ubuntu-22.04"
    dbapp01.vm.box_check_update = false
    dbapp01.vm.network "private_network", type: "static", ip: "172.16.238.11"

    dbapp01.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "dbapp01"
      vb.memory = "1024"
    end

    # Installation et configuration de postgresql et creation de la base de donnees dbapp01
    dbapp01.vm.provision "shell", path: "config_postgresql.sh"
  end

  #Instance de sauvegarde code source et base de donnees
  config.vm.define "backup01" do |backup01|
    backup01.vm.box = "bento/ubuntu-22.04"
    backup01.vm.box_check_update = false
    backup01.vm.network "private_network", type: "static", ip: "172.16.238.12"

    backup01.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.name = "backup01"
      vb.memory = "1024"
    end
  end
end
