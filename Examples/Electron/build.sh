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
# Compile Node and Browser parts separately to prevent class name clashes.

../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Node +t ../../Smalltalk/Electron/Node src/Node out
../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Browser +t ../../Smalltalk/Electron/Browser src/Browser out

# Pre-launch script

echo "Pre-launch script"
./preLaunch.sh

# Run tests
# If this fails on Ubuntu, you maybe need to run this:
#     sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0

cd out
../node_modules/.bin/electron main.js -test
