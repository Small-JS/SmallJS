#!/bin/bash
# Start AI MCP app: asks Ollama a question, using the tools of the MCP server.
# Ollama must be running, e.g. started with startOllama.sh.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

set -o allexport
source .env
set +o allexport

node out/main.js
