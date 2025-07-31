#!/bin/bash
# This script builds the NodeGui project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

# Check for MacOs on ARM, for which there is currently no precompiled NodeGui binary.

if
	test `uname` = "Darwin" && test `uname -m` != "x86_64"
then
	echo "NodeGui MacOS ARM support is currently limited (2025-02-08), exiting."
	exit 0;
fi

echo "==== Example NodeGui"

# Compile TypeScript

echo "tsc Example NodeGui"
npx tsc

# Compile Smalltalk

../../Compiler/start.sh -t ../../Smalltalk/Core ../../Smalltalk/Node +t ../../Smalltalk/NodeGui src out

# Run tests
# If this fails on Ubuntu, you maybe need to run this:
#     sudo apt-get install libxcb-cursor0

node_modules/.bin/qode out/main.js -test
