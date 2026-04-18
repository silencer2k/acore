#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"

header "Installing dependencies"
sudo apt update && sudo apt -y install curl git sudo unzip zip

header "Cloning repositories"
while read -r path repo; do
	step "$repo" "$path"
	git clone "$repo" "$BASE_DIR/$path" || true
done < "$BASE_DIR/config/repos.conf"

header "Creating directories"
while read -r path; do
	step "$path"
	mkdir -p "$BASE_DIR/$path"
done < "$BASE_DIR/config/mkdirs.conf"

header "Creating symlinks"
while read -r symlink path; do
	step "$path" "$symlink"
	ln -sn "$path" "$BASE_DIR/$symlink" || true
done < "$BASE_DIR/config/symlinks.conf"
