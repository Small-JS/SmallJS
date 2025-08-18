#!/bin/bash
# This script installs NPM dependencies of the Shop Server project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Installing NPM packages for: Example Electron"
npm install