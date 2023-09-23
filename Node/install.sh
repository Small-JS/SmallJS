#!/bin/bash
# This script installs NPM dependencies of the Node project.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "Installing NPM packages for Node"
npm install --silent
