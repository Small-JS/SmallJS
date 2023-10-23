#!/bin/bash
# This script builds Todo project. x

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Todo"

# Compile TypeScript
echo "tsc Todo"
tsc

# Compile Smalltalk
node ../../Compiler/out/App.js -t ../../Smalltalk/Core ../../Smalltalk/Browser +t src web/Smalltalk
