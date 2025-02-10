#!/bin/bash
# This script builds the core SmallJS compenents:
# The Compiler, Playgrond, Node and Browser projects

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Building SmallJS core components"

./Compiler/build.sh
./Node/build.sh
./Browser/build.sh
./Playground/build.sh

echo "==== Core component builds successful"
