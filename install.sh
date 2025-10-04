#!/bin/bash
# This script
# 	- checks SmallJS prerequisite applications
# 	- Installs the SmallJS language extension in VSCode.
#	- Installs npm dependencies

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Detecting prerequisite applications"
echo "Note: For installing prerequisite apps, see: Documentation/Prerequisites.md."

echo -n "Detecting Visual Studio Code: "
code -v

echo -n "Detecting Node.js: "
node -v

echo -n "Detecting npm: "
npm -v

# TypeScript must be installed globally to work from VSCode.
echo -n "Detecting TypeScript: "
tsc -v

# Check npx dependencies here to force first-time installation

echo "Detecting http-server: "
npx http-server --version

echo "Detecting kill-port: "
npx kill-port
# kill-port does not produce output.
echo "OK".

echo "==== Installing core npm packages"

./Extension/install.sh
./Compiler/install.sh
./Node/install.sh

echo "==== All core installs successful"
