#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"
sudo true

cd "$BASE_DIR/data"

rm -rf dbc maps Cameras Buildings vmaps mmaps
mkdir -p Buildings vmaps mmaps

./map_extractor
./vmap4_extractor
./vmap4_assembler Buildings vmaps
./mmaps_generator
