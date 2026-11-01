#!/bin/bash
# This script builds the AI MCP project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Building: Example AI MCP"

# Compile TypeScript

echo "tsc AI MCP"
tsc

# Compile Smalltalk

../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Node +t ../../../Smalltalk/AI/Shared ../../../Smalltalk/AI/Node src out

# Run tests

node out/main.js -test
