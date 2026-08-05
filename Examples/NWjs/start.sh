#!/bin/sh

# Exit script if a step fails.
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

# ./bin/nw web --enable-features=NWESM,NWChainImportNode
./node_modules/.bin/nw web --enable-features=NWESM,NWChainImportNode
