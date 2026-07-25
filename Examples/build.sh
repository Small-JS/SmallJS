#!/bin/bash
# This script builds all SmallJS examples and runs their tests.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Building: Examples"

./Counter/build.sh
./Todo/build.sh
./Balls/build.sh
./Benchmark/build.sh
./WebWorkers/build.sh
./Shop/build.sh
./PWA/build.sh
./Electron/build.sh
./NodeGui/build.sh
./NWjs/build.sh
./AI/build.sh

echo "==== Examples built successfully"
