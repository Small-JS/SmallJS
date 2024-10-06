#!/bin/bash
# This script builds the Shop Server project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Example NodeGui"

# Compile TypeScript

echo "tsc Example NodeGui"
tsc

# Compile Smalltalk

node ../../Compiler/out/App.js ../../Smalltalk/Core ../../Smalltalk/Node ../../Smalltalk/NodeGui src out

# Run tests

node_modules/.bin/qode out/App.js -test
