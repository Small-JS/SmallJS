#!/bin/bash
# Start AI Server.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

set -o allexport
source .env
set +o allexport

node out/main.js
