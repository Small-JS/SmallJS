#!/bin/bash
# Start node static web server.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

# Start Pharo from current folder.

vm/Pharo Pharo.image &