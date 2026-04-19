#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"
sudo true

BACKUP_NAME="$(hostname -s)-$(date +"%Y-%m-%d-%H-%M-%S")"
BACKUP_DIR="$BASE_DIR/tmp/$BACKUP_NAME"

mkdir -p "$BACKUP_DIR"

header "Copying configuration"
for file in $(find $(abspath etc/) -name '*.conf'); do
	bfile=$(relpath "$file")
	step "$bfile"
	mkdir -p "$BACKUP_DIR/$(dirname "$bfile")"
	cp "$file" "$BACKUP_DIR/$bfile"
done

header "Dumping databases"
for database in $(echo "show databases" | sudo mysql | grep ^acore_); do
	step "$database"
	sudo mysqldump --hex-blob "$database" > "$BACKUP_DIR/$database.sql"
done

header "Creating archive"
mkdir -p "$(abspath backup)"
cd "$BACKUP_DIR"
zip -r "$(abspath "backup/$BACKUP_NAME")" .

rm -rf "$BACKUP_DIR"
