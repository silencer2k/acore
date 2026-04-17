#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$0")")"
source "common.sh"

if [ ! -d "$AC_CODE_DIR" ]; then
	$SCRIPT_DIR/acore-fetch.sh
fi

cd "$AC_CODE_DIR"

header "Installing dependencies"
./acore.sh install-deps

header "Compiling sources"
CTOOLS_BUILD=all ./acore.sh compiler all

header "Configuring database"
cat "$SCRIPT_DIR/conf/create_db.sql"
sudo mysql < "$SCRIPT_DIR/conf/create_db.sql"
