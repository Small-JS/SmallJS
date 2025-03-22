#!/bin/bash
# This script builds the Compiler.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Compiler"

# Compile TypeScript
echo "tsc Compiler"
npx tsc
