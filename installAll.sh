#!/bin/bash
# This script installs all SmallJS components and runs their tests:
# The core compenents, examples and website.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

./install.sh
./Examples/install.sh

echo "==== All installs successful"
