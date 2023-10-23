#!/bin/bash
# This script builds the Counter project. x

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Counter"

# Compile TypeScript
echo "tsc Counter"
tsc

# Compile Smalltalk
node ../../Compiler/out/App.js -t ../../Smalltalk/Core ../../Smalltalk/Browser +t src web/Smalltalk
