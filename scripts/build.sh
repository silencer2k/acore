#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"
sudo true

if [ ! -d "$AC_CODE_DIR" ]; then "$SCRIPT_DIR/prereq.sh"; fi

find $(abspath etc/) -name '*.conf.dist' -exec cp {} {}.old \;

header "Compiling sources"
CTOOLS_BUILD=all "$AC_CODE_DIR/acore.sh" compiler all

header "Updating configuration"
for file in $(find $(abspath etc/) -name '*.conf'); do
	step "$(relpath "$file")"

	if [[ -f "$file.dist" && -f "$file.dist.old" ]]; then
		diff -u "$file.dist.old" "$file.dist" | patch "$file"
		rm "$file.dist.old"
	fi

	sed -E -i 's|^(DataDir\s*=\s*\")\.(\")|\1'"$BASE_DIR/data"'\2|' "$file"
	sed -E -i 's|^(LogsDir\s*=\s*\")(\")|\1'"$BASE_DIR/logs"'\2|' "$file"
	sed -E -i 's|^(TempDir\s*=\s*\")(\")|\1'"$BASE_DIR/tmp"'\2|' "$file"
done

header "Installing services"
for file in $(abspath config/systemd/*.service); do
	step "$(basename "$file")"
	cat "$file" | envsubst | sudo tee "/etc/systemd/system/$(basename "$file")"
done
sudo systemctl daemon-reload
