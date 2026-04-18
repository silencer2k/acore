#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"
sudo true

header "Installing dependencies"
sudo apt update && sudo apt -y install curl git sudo unzip zip

header "Cloning repositories"
while read -r path repo; do
	step "$repo" "$path"
	git clone "$repo" "$(abspath "$path")" || true
done < "$(abspath config/repos.conf)"

header "Creating directories"
while read -r path; do
	step "$path"
	mkdir -p "$(abspath "$path")"
done < "$(abspath config/mkdirs.conf)"

header "Creating symlinks"
while read -r symlink path; do
	step "$path" "$symlink"
	ln -sn "$path" "$(abspath "$symlink")" || true
done < "$(abspath config/symlinks.conf)"
