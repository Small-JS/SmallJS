#!/bin/bash
# Update npm dependencies for contributions.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

./CounterUsingMithril/update.sh
