#!/bin/bash
# Update NPM dependencies for examples.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

cwd=$(pwd)

echo "==== Examples: Shop Server"
cd $cwd/Shop/Server
ncu -u
npm install

echo "==== Examples: Electron"
cd $cwd/Electron
ncu -u
npm install

echo "==== Examples: NodeGui"
cd $cwd/NodeGui
ncu -u
npm install

