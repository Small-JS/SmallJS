#!/bin/bash
# This script builds the Shop Server project.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Shop Server"

# Check and run .env file
if
	! test -f .env
then
	echo "Warning: '.env' file missing. See '.env.example'."
else
	set -o allexport
	source .env
	set +o allexport
fi

# Compile TypeScript
echo "tsc Shop Server"
tsc

# Compile Smalltalk
node ../../../Compiler/out/App.js -t ../../../Smalltalk/Core +t ../../../Smalltalk/Node src out
