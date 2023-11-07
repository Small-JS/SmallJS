#!/bin/bash
# This script builds Benchmark Browser project.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Benchmark"

# Compile TypeScript
echo "tsc Benchmark"
tsc

# Compile Smalltalk
node ../../Compiler/out/App.js -t ../../Smalltalk/Core ../../Smalltalk/Browser +t src web/Smalltalk
