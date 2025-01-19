#!/bin/bash
# Start Node server.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

set -o allexport
source .env
set +o allexport

node --experimental-sqlite out/main.js
