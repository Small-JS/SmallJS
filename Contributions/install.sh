#!/bin/bash
# This script installs npm dependencies for the contributions.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

./CounterUsingMithril/install.sh
