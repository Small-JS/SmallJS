#!/bin/bash
# This script builds all SmallJS examples and runs their tests.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Building: Contributions"

./Frequencies/build.sh
./CounterUsingMithril/build.sh
./ReactCounter/build.sh
./Pharo/build.sh

echo "==== Contributions built successfully"
