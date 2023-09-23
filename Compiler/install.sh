#!/bin/bash
# This script installs NPM dependencies of the Compiler.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "Installing NPM packages for Compiler"
npm install --silent
