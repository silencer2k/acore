#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$0")")"
source "common.sh"

cd data

rm -rf dbc maps Cameras Buildings vmaps mmaps
mkdir -p Buildings vmaps mmaps

./map_extractor
./vmap4_extractor
./vmap4_assembler Buildings vmaps
./mmaps_generator
