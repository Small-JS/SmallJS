#!/bin/bash

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

rm -f smalljs.db
