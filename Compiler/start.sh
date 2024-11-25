#!/bin/bash
# This script starts the Compiler with arguments passed through.

# Exit script if a step fails
set -e

# Find compiler relative to this script folder without changing the cwd.
node "$(dirname "$0")"/out/main.js "$@"
