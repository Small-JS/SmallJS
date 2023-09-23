#!/bin/bash
# This script builds all SmallJS components and and tests where possible from the command line.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

./Compiler/build.sh
./Node/build.sh
./Browser/build.sh
./Shop/Server/build.sh
./Shop/Client/build.sh

echo "==== All builds successful"
