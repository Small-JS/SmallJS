#!/bin/sh

# Exit script if a step fails.
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

node_modules/.bin/qode out/main.js
