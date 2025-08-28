#!/bin/bash
# This script installs npm dependencies of this project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Installing npm packages for: Example AI Server"
npm install
