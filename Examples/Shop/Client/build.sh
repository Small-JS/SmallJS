#!/bin/bash
# This script builds Shop Client project.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Shop Client"

# Compile TypeScript
echo "tsc Shop Client"
tsc

# Compile Smalltalk
node ../../../Compiler/out/App.js ../../../Smalltalk/Core ../../../Smalltalk/Browser src web/Smalltalk