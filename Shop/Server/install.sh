#!/bin/bash
# This script installs NPM dependencies of the Shop Server project.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "Installing NPM packages for Shop Server"
npm install --silent
