#!/bin/bash
# This script starts the Electron example app.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

# Start Electron example app

cd out
../node_modules/.bin/electron main.js
