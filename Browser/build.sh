#!/bin/bash
# This script builds the Browser project.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Browser"

# Compile TypeScript
echo "tsc Browser"
tsc

# Compile Smalltalk
node ../Compiler/out/App.js ../Smalltalk/Core ../Smalltalk/Browser src web/Smalltalk
