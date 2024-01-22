#!/bin/bash
# This script builds the Shop Server project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Shop Server"

# Compile TypeScript

echo "tsc Shop Server"
tsc

# Compile Smalltalk

node ../../../Compiler/out/App.js -m ShopServer -t ../../../Smalltalk/Core ../../../Smalltalk/Node +t src out

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

node out/App.js -test
