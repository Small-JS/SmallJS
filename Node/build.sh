#!/bin/bash
# This script builds and tests the Node project.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Node"

# Compile TypeScript
echo "tsc Node"
tsc

# Compile Smalltalk
node ../Compiler/out/App.js ../Smalltalk/Core ../Smalltalk/Node src out

# Check and run .env file
if
	! test -f .env
then
	echo "Warning: '.env' file missing. See '.env.example'."
	echo "Skipping browser tests."
	exit 0
fi

set -o allexport
source .env
set +o allexport

node out/App.js
