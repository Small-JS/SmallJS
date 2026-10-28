#!/bin/bash
# This script builds the NodeGui project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Building: Contribution NodeGui"

# Compile TypeScript

echo "tsc Contribution NodeGui"
tsc

# Compile Smalltalk

../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Node +t ../../Smalltalk/NodeGui src out

# Run tests
# If this fails on Ubuntu, you maybe need to run this:
#     sudo apt-get install libxcb-cursor0

# 2026-10-28: NWjs may print warnings like:
# "QThreadStorage: entry 1 destroyed before end of thread 0x..."
# This this is a bug in NWjs, but does not extit the script with a failure.

./node_modules/.bin/qode out/main.js -test

echo "NodeGui finished"
