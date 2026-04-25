#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"
sudo true

header "Updating repositories"
while read -r path repo; do
	step "$repo" "$path"
	cd "$(abspath "$path")"
	git fetch -p && git pull
done < "$(abspath config/repos.conf)"
