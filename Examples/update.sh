#!/bin/bash
# Update NPM dependencies for examples.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

cwd=$(pwd)

echo "==== Examples: Shop Server"
cd $cwd/Shop/Server
npx npm-check-updates -u
npm install

echo "==== Examples: AI Server"
cd $cwd/AI/Server
npx npm-check-updates -u
npm install

echo "==== Examples: Electron"
cd $cwd/Electron
npx npm-check-updates -u
npm install

echo "==== Examples: NodeGui"
cd $cwd/NodeGui
npx npm-check-updates -u
npm install

