#!/bin/bash
# This script removes all installed / compiled / generated artifacts for this project.

# Exit script if a step fails
set -e
# Change to script folder.
cd "$(dirname "$0")"

./Server/clean.sh
./Client/clean.sh
./ClientSpa/clean.sh
