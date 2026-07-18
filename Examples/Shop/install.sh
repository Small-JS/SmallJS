#!/bin/bash
# This script installs npm dependencies for the examples.
# It assumes dependencies have been checked by parent script.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

./Server/install.sh

