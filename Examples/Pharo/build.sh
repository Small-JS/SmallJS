#!/bin/bash
# This script builds the Pharo projects.

# Exit script if a step fails
set -e
# Change to script folder.
cd "$(dirname "$0")"

./Client/build.sh
