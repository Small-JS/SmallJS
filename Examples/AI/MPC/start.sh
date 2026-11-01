#!/bin/bash
# Start AI MCP server. It serves MCP over stdin and stdout.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

node out/main.js
