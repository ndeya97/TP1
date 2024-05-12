#!/bin/bash

# Chemin du fichier pg_hba.conf
PG_HBA_CONF="/etc/postgresql/14/main/pg_hba.conf"

# Ajouter une règle pour autoriser l'accès depuis la machine devapp01
echo "host    all             all             172.16.238.10/32            md5" | sudo tee -a $PG_HBA_CONF > /dev/null

# Redémarrer PostgreSQL pour appliquer les changements
sudo systemctl restart postgresql