#!/bin/bash

# Installation de PostgreSQL
sudo apt-get update
sudo apt-get install -y postgresql-14 postgresql-contrib

# Configuration pour permettre l'acces uniquement depuis l'adresse IP de devapp01
echo "host    all             all             172.16.238.10/24         md5" | sudo tee -a /etc/postgresql/14/main/pg_hba.conf

# Definition du mot de passe pour l'utilisateur postgres
echo "ALTER USER postgres PASSWORD 'postgres';" | sudo -u postgres psql

# Creation de la base de donnees dbapp01 en utilisant l'utilisateur postgres
sudo -u postgres psql -c "CREATE DATABASE dbapp01;"

# Redemarrage de PostgreSQL pour appliquer les changements de configuration
sudo systemctl restart postgresql
