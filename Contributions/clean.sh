#!/bin/bash
# This script removes all installed / compiled / generated artifacts from the examples.
# Used for testing the scripts install.sh and build.sh

# Set working directory to script directory.
cd "$(dirname "$0")"

echo "Removing compiled code from contributions..."

./Frequencies/clean.sh
./CounterUsingMithril/clean.sh
./Pharo/clean.sh
