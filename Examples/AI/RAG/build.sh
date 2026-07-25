#!/bin/bash
# This script builds the AI Server project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Building: Example AI RAG"

# Compile TypeScript

echo "tsc AI RAG"
tsc

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

# Start Ollama
# Note Ollama must be started before setting the environment variables
# because Ollama uses the same variables, but in a different way.

echo "Starting Ollama server"
ollama serve > ollama.log 2>&1  &
sleep 6

# Set and export environment variables variables.

set -o allexport
source .env
set +o allexport

# Run tests

node out/main.js -test

# Terminate Ollama

echo "Terminating Ollama"
npx kill-port 11434
sleep 4
