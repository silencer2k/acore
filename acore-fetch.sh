#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$0")")"
source "common.sh"

header "Installing dependencies"
sudo apt update && sudo apt -y install git curl unzip sudo

header "Cloning repositories"
while read -r path repo; do
	step "$repo" "$path"
	git clone "$repo" "$path" || true
done < "$SCRIPT_DIR/conf/repos.conf"

header "Creating directories"
while read -r path; do
	step "$path"
	mkdir -p "$path"
done < "$SCRIPT_DIR/conf/dirs.conf"

header "Creating symlinks"
while read -r symlink path; do
	step "$path" "$symlink"
	ln -sn "$path" "$symlink" || true
done < "$SCRIPT_DIR/conf/symlinks.conf"
