#!/bin/bash
# This script removes all installed / compiled / generated artifacts from the examples.
# Used for testing the scripts install.sh and build.sh

# Set working directory to script directory.
cd "$(dirname "$0")"

echo "Removing compiled code from examples..."

./AI/clean.sh
./Balls/clean.sh
./Benchmark/clean.sh
./Counter/clean.sh
./Electron/clean.sh
./NodeGui/clean.sh
./NWjs/clean.sh
./Shop/clean.sh
./Todo/clean.sh
./WebWorkers/clean.sh
