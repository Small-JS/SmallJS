#!/bin/bash
# This script removes all installed / compiled / generated artifacts from the examples.
# Used for testing the scripts install.sh and build.sh

# Set working directory to script directory.
cd "$(dirname "$0")"

echo "Removing compiled code from examples..."

./Balls/clean.sh
./Benchmark/clean.sh
./Counter/clean.sh
./Electron/clean.sh
./NodeGui/clean.sh
./Pharo/Client/clean.sh
./Shop/Client/clean.sh
./Shop/ClientSpa/clean.sh
./Shop/Server/clean.sh
./Todo/clean.sh
./WebWorkers/clean.sh
