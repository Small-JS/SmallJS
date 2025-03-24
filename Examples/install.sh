#!/bin/bash
# This script installs npm dependencies for the examples.
# It assumes dependencies have been checked by parent script.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

echo "==== Installing NPM dependencies for examples"

./Shop/Server/install.sh
./Electron/install.sh
./NodeGui/install.sh
./CounterUsingMithril/install.sh
