#!/bin/bash

# Creation du script de sauvegarde
cat <<EOL > /home/vagrant/backup_code.sh
#!/bin/bash

# Repertoire de l'application
APP_DIR="/opt/fintechapp"
# Repertoire de sauvegarde sur backup01
BACKUP_DIR="vagrant@172.16.238.12:/home/vagrant/backup/fintechapp"

# Utiliser rsync pour copier les fichiers
rsync -avz \$APP_DIR \$BACKUP_DIR
EOL

# Rendre le script executable
chmod +x /home/vagrant/backup_code.sh

# Ajouter le cron job
(crontab -l 2>/dev/null; echo "0 * * * * /home/vagrant/backup_code.sh") | crontab -
