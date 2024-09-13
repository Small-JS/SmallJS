#!/bin/bash
# This script builds and tests Electron example project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Electron example"

# Compile TypeScript

echo "tsc Electron example"
tsc

# Compile Smalltalk

node ../../Compiler/out/App.js -t ../../Smalltalk/Core ../../Smalltalk/Node ../../Smalltalk/Browser +t ../../Smalltalk/Electron src out

# Pre-launch script

echo "Pre-launch script"
./preLaunch.sh

# Run tests

cd out
../node_modules/.bin/electron main.js -test
