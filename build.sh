#!/bin/bash
# This script builds all SmallJS components and runs their tests.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

./Compiler/build.sh
./Node/build.sh
./Browser/build.sh
./Examples/Counter/build.sh
./Examples/Todo/build.sh
./Examples/Benchmark/build.sh
./Examples/Shop/Server/build.sh
./Examples/Shop/Client/build.sh
./Examples/Shop/ClientSpa/build.sh
./Website/build.sh

echo "==== All builds successful"
