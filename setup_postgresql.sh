#!/bin/bash

# Installation de PostgreSQL
sudo apt-get update
sudo apt-get install -y postgresql-14

# Modification du fichier de configuration PostgreSQL pour écouter sur le port 5432
sudo sed -i "s/#port = 5432/port = 5432/" /etc/postgresql/14/main/postgresql.conf
sudo systemctl restart postgresql