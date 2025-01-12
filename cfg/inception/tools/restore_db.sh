#!/bin/bash
BACKUP_FILE="$1"
DB_NAME="wordpress_db"

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: restore_db.sh <backup_file.sql>"
    exit 1
fi

docker exec -i mariadb_container_name mysql -u root -p"${MYSQL_ROOT_PASSWORD}" "$DB_NAME" < "$BACKUP_FILE"
echo "Database restored from $BACKUP_FILE"
