#!/bin/bash
# This script installs npm dependencies of this project.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Installing npm packages for: Example NodeGui"
npm install
npm install-scripts approve @nodegui/qode
# Run install a second time to ensure install scripts are run.
npm install
