#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"

header "Updating databases"

for file in "$BASE_DIR/src/mod-arac/data/sql/db-world/arac.sql"; do
	step "$(relpath "$file")"
	sudo mysql acore_world < $file
done
