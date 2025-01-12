#!/bin/bash
BACKUP_DIR="/backups"
DB_NAME="wordpress_db"

mkdir -p "$BACKUP_DIR"
docker exec mariadb_container_name mysqldump -u root -p"${MYSQL_ROOT_PASSWORD}" "$DB_NAME" > "$BACKUP_DIR/${DB_NAME}_$(date +%F).sql"
echo "Database backed up to $BACKUP_DIR/${DB_NAME}_$(date +%F).sql"
