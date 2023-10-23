#!/bin/bash
# This script builds Shop Client project. x

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Shop Client"

# Compile TypeScript
echo "tsc Shop Client"
tsc

# Compile Smalltalk
node ../../../Compiler/out/App.js -t ../../../Smalltalk/Core ../../../Smalltalk/Browser +t src web/Smalltalk
