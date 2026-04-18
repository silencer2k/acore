#!/bin/bash
set -e
cd "$(dirname "$(readlink -f "$0")")"

find . -name '*.conf' -exec diff --color=always -u {}.dist {} \; | less -R
