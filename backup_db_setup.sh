#!/bin/bash

# Variables
BACKUP_DIR="/home/vagrant/backup"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_FILE="dbapp01_$TIMESTAMP.sql"
REMOTE_DIR="vagrant@172.16.238.12:/home/vagrant/backup/dbapp01"

# Creation de la sauvegarde
sudo -u postgres pg_dump dbapp01 > $BACKUP_DIR/$BACKUP_FILE

# Copie du backup vers backup01
scp $BACKUP_DIR/$BACKUP_FILE $REMOTE_DIR

# Clean up local backup files older than 7 days
find $BACKUP_DIR -type f -name "*.sql" -mtime +7 -exec rm {} \;


# Creation du script de sauvegarde pour PostgreSQL
cat <<EOL > /home/vagrant/backup_db.sh
#!/bin/bash

# Variables
DB_NAME="dbapp01"
DB_USER="postgres"
BACKUP_DIR="/home/vagrant/db_backups"
REMOTE_BACKUP_DIR="vagrant@172.16.238.12:/home/vagrant/backup/db_backups"

# Creation du repertoire de sauvegarde local s'il n'existe pas
mkdir -p \$BACKUP_DIR

# Nom du fichier de sauvegarde
BACKUP_FILE="\$BACKUP_DIR/\$DB_NAME-\$(date +\%Y-\%m-\%d-\%H:\%M:\%S).sql"

# Sauvegarde de la base de donnees PostgreSQL
pg_dump -U \$DB_USER \$DB_NAME > \$BACKUP_FILE

# Utiliser rsync pour copier les fichiers vers la machine de sauvegarde
rsync -avz \$BACKUP_DIR \$REMOTE_BACKUP_DIR
EOL

# Rend le script executable
chmod +x /home/vagrant/backup_db.sh

# Ajouter le cron job pour une execution toutes les 30 minutes
(crontab -l 2>/dev/null; echo "*/30 * * * * /home/vagrant/backup_db.sh") | crontab -
