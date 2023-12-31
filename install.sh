#!/bin/bash
# This script
# 	- checks SmallJS prerequisite appplications
# 	- Installs the SmallJS language extension in VSCode.
#	- Installs npm dependencies

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Detecting prerequisite applications"

echo -n "Detecting NPM: "
npm -v

echo -n "Detecting Node.js: "
node -v

echo -n "Detecting TypeScript: "
tsc -v

echo -n "Detecting Visual Studio Code: "
code -v

./Extension/install.sh

echo "==== Installing NPM dependencies"

./Compiler/install.sh
./Node/install.sh
./Examples/Shop/Server/install.sh

echo "==== All installs successful"