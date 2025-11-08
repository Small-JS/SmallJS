#!/bin/bash
# This script builds all SmallJS examples and runs their tests.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Building SmallJS contributions"

./CounterUsingMithril/build.sh
./Pharo/build.sh

echo "==== Contribution builds successful"
