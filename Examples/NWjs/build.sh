#!/bin/bash
# This script builds and tests this project.

# Exit script if a step fails.
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== NWjs"

# Compile TypeScript

echo "tsc NWjs"
npx tsc

# Compile Smalltalk

../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Browser ../../Smalltalk/Node/Base ../../Smalltalk/Node/File +t ../../Smalltalk/NWjs src web/Script

# Run NW app

echo "Running NW app"
./node_modules/.bin/nw web --enable-features=NWESM,NWChainImportNode -test
