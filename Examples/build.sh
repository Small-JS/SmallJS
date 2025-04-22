#!/bin/bash
# This script builds all SmallJS examples and runs their tests.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Building SmallJS examples"

./Counter/build.sh
./Todo/build.sh
./Balls/build.sh
./Benchmark/build.sh
./WebWorkers/build.sh
./Shop/build.sh
./AI/build.sh
./Electron/build.sh
./NodeGui/build.sh
./Pharo/Client/build.sh

echo "==== Example builds successful"
