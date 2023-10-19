#!/bin/bash
# This script builds all SmallJS components and and tests where possible from the command line.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

./Compiler/build.sh
./Node/build.sh
./Browser/build.sh
./Examples/Counter/build.sh
./Examples/Todo/build.sh
./Examples/Shop/Server/build.sh
./Examples/Shop/Client/build.sh

echo "==== All builds successful"
