#!/bin/bash
# This script builds the AI Server project.

# Exit script if a step fails
set -e
# Change to script folder.
cd "$(dirname "$0")"

./Server/build.sh
./Client/build.sh
./ClientSpa/build.sh
