#!/bin/bash

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Cleaning: Example AI RAG database"

rm -f vector.db
