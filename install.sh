#!/bin/bash
# This script
# 	- checks SmallJS prerequisite applications
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

echo "==== Detecting global npm packages"

echo -n "Detecting npm: "
npm -v

echo "==== Installing local npm packages"

npm install

echo "==== Detecting local npm packages"

echo "Detecting TypeScript: "
npx tsc -v

echo "Detecting VS Code Extension Manager: "
npx vsce --version

echo "Detecting http-server: "
npx http-server -v

./Extension/install.sh

echo "==== Installing core npm dependencies"

./Compiler/install.sh
./Node/install.sh

echo "==== All core installs successful"
