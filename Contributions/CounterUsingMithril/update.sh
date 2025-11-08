#!/bin/bash
# Update npm dependencies for examples.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Updating: CounterUsingMithril"
npx npm-check-updates -u
./install.sh
