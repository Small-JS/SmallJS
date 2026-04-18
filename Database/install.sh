#!/bin/bash
# This script creates example databases
# Currently only SQLite.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Creating databases"

./SQLite/install.sh

