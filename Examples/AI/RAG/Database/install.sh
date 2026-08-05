#!/bin/bash
# This script creates the SQLite example database

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== SQLite vector database"

npm install

node createSqliteDatabase.js
