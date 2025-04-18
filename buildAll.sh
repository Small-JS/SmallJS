#!/bin/bash
# This script builds all SmallJS components and runs their tests:
# The core compenents, examples and website.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

./build.sh
./Examples/build.sh

echo "==== All builds successful"
