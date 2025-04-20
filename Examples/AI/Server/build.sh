#!/bin/bash
# This script builds the AI Server project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== AI Server"

# Compile TypeScript

echo "tsc AI Server"
npx tsc

# Compile Smalltalk

../../../Compiler/start.sh -t ../../../Smalltalk/Core ../../../Smalltalk/Node +t ../../../Smalltalk/AI/Shared ../../../Smalltalk/AI/Node src out

# Check and run .env file

if
	! test -f .env
then
	echo "Warning: '.env' file missing. See '.env.example'."
	echo "Skipping tests."
	exit 0
fi
set -o allexport
source .env
set +o allexport

# Run tests

node out/main.js -test
