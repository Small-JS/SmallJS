#!/bin/bash
# This script builds the Compiler.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Compiler"

# Compile TypeScript
echo "tsc Compiler"
tsc
