#!/bin/bash
set -e
source "$(dirname "$(readlink -f "$0")")/_common.sh"

cd "$BASE_DIR/data"

rm -rf dbc maps Cameras Buildings vmaps mmaps
mkdir -p Buildings vmaps mmaps

"$AC_CODE_DIR/env/dist/bin/map_extractor"
"$AC_CODE_DIR/env/dist/bin/vmap4_extractor"
"$AC_CODE_DIR/env/dist/bin/vmap4_assembler" Buildings vmaps
"$AC_CODE_DIR/env/dist/bin/mmaps_generator"
