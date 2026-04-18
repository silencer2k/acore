#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$0")")"
source "common.sh"

if [ ! -d "$AC_CODE_DIR" ]; then
	$SCRIPT_DIR/acore-prereq.sh
fi

BACKUP_NAME="backup-$(date +"%Y-%m-%d-%H-%M-%S")"
BACKUP_DIR="$SCRIPT_DIR/tmp/$BACKUP_NAME"

mkdir -p "$BACKUP_DIR"

header "Copying configuration"
for file in $(find "$SCRIPT_DIR/etc/" -name '*.conf'); do
	step "$file"
	mkdir -p "$BACKUP_DIR/$(dirname "$file")"
	cp "$file" "$BACKUP_DIR/$file"
done

header "Dumping databases"
for database in $(echo "show databases" | sudo mysql | grep ^acore_); do
	step "$database"
	sudo mysqldump --hex-blob "$database" > "$BACKUP_DIR/$database.sql"
done

header "Creating archive"
cd "$BACKUP_DIR"
zip -r backup .
cd "$SCRIPT_DIR"

mkdir -p "$SCRIPT_DIR/backup"
mv "$BACKUP_DIR/backup.zip" "$SCRIPT_DIR/backup/$BACKUP_NAME.zip"
rm -rf "$BACKUP_DIR"
