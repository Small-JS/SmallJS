#!/bin/bash
# This script
# 	- checks SmallJS prerequisite appplications
# 	- Installs the SmallJS language extension in VSCode.
#	- Installs npm dependencies

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "Note: See Documentation/Prerequisites.md for installation instructions."

echo "==== Detecting prerequisite applications"

echo -n "Detecting Node.js: "
node -v

echo -n "Detecting Visual Studio Code: "
code -v

echo "==== Detecting global NPM packages"

echo -n "Detecting NPM: "
npm -v

echo "==== Installing local NPM packages"

npm install

echo "==== Detecting local NPM packages"

echo -n "Detecting TypeScript: "
npx tsc -v

echo -n "Detecting VS Code Extension Manager: "
npx vsce --version

echo -n "Detecting http-server: "
npx http-server -v

./Extension/install.sh

echo "==== Installing core NPM dependencies"

./Compiler/install.sh
./Node/install.sh
./Examples/install.sh

echo "==== All installs successful"
