#!/bin/bash
# This script builds and tests the Node project.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Node"

# Compile TypeScript
echo "tsc Node"
npx tsc

# Compile Smalltalk
../Compiler/start.sh ../Smalltalk/Core ../Smalltalk/Node src out

# Check and run .env file
if
	! test -f .env
then
	echo "Warning: '.env' file missing. See '.env.example'."
	echo "Running limited tests."
else
	set -o allexport
	source .env
	set +o allexport
fi

node --experimental-sqlite out/main.js
