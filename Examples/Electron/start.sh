#!/bin/bash
# This script starts the Electron example app.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

# Start Electron example app

# VSCode terminals set ELECTRON_RUN_AS_NODE, which makes Electron run as plain Node.js.
unset ELECTRON_RUN_AS_NODE

# If this fails on Ubuntu, you maybe need to run this:
#     sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0

cd out
../node_modules/.bin/electron --no-sandbox main.js
