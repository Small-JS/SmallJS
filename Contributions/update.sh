#!/bin/bash
# Update npm dependencies for contributions.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

cwd=$(pwd)

echo "==== Contributions: CounterUsingMithril"

cd $cwd/CounterUsingMithril
npx npm-check-updates -u
npm install

