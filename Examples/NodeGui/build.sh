#!/bin/bash
# This script builds the NodeGui project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Example NodeGui"

# Compile TypeScript

echo "tsc Example NodeGui"
npx tsc

# Compile Smalltalk

../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Node +t ../../Smalltalk/NodeGui src out

# Run tests
# If this fails on Ubuntu, you maybe need to run this:
#     sudo apt-get install libxcb-cursor0

node_modules/.bin/qode out/main.js -test
