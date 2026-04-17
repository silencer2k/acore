#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$0")")"
source "common.sh"

if [ ! -d "$AC_CODE_DIR" ]; then
	$SCRIPT_DIR/acore-prereq.sh
fi

cd "$AC_CODE_DIR"

header "Installing dependencies"
./acore.sh install-deps

header "Configuring dependencies"
step "mysqld-acore.cnf"
sudo tee /etc/mysql/mysql.conf.d/mysqld-acore.cnf < "$SCRIPT_DIR/conf/mysqld-acore.cnf"
sudo systemctl restart mysql

header "Compiling sources"
CTOOLS_BUILD=all ./acore.sh compiler all

header "Configuring database"
cat "$SCRIPT_DIR/conf/create_db.sql"
sudo mysql < "$SCRIPT_DIR/conf/create_db.sql"

header "Installing services"
for file in $SCRIPT_DIR/conf/systemd/*.service; do
	step "$(basename "$file")"
	export SCRIPT_USER AC_CODE_DIR
	cat "$file" | envsubst | sudo tee "/etc/systemd/system/$(basename "$file")"
done
sudo systemctl daemon-reload
