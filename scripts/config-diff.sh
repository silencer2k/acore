#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"

cd "$BASE_DIR/etc"
find . -name '*.conf' -exec diff --color=always -u {}.dist {} \; | less -R
