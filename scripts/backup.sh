#!/bin/bash

# Configuration
BACKUP_DIR="backups"
WORKFLOW_BACKUP_DIR="$BACKUP_DIR/workflows/$(date +%Y-%m-%d)"
DB_BACKUP_DIR="$BACKUP_DIR/database/$(date +%Y-%m-%d)"
CONTAINER_PREFIX="n8n-project"

# Create backup directories
mkdir -p "$WORKFLOW_BACKUP_DIR"
mkdir -p "$DB_BACKUP_DIR"

# Backup MySQL database
echo "Backing up MySQL database..."
docker exec ${CONTAINER_PREFIX}-mysql-1 mysqldump -u n8n -pn8n_password n8n > "$DB_BACKUP_DIR/mysql_backup.sql"

# Export workflows using n8n CLI
echo "Exporting workflows..."
docker exec ${CONTAINER_PREFIX}-n8n-1 n8n export:workflow --all --output=/home/node/.n8n/workflows_backup.json
docker cp ${CONTAINER_PREFIX}-n8n-1:/home/node/.n8n/workflows_backup.json "$WORKFLOW_BACKUP_DIR/"

# Create a dated archive
echo "Creating archive..."
cd "$BACKUP_DIR" || exit
tar -czf "n8n_backup_$(date +%Y-%m-%d).tar.gz" "workflows/$(date +%Y-%m-%d)" "database/$(date +%Y-%m-%d)"

echo "Backup completed!"
echo "Backup location: $BACKUP_DIR/n8n_backup_$(date +%Y-%m-%d).tar.gz"

# Git operations
echo "Adding backup to Git..."
git add "$BACKUP_DIR/n8n_backup_$(date +%Y-%m-%d).tar.gz"
git commit -m "Backup: $(date +%Y-%m-%d)"

echo "Done! Don't forget to push your changes to remote repository."
