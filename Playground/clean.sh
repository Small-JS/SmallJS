#!/bin/bash
# This script removes all installed / compiled / generated artifacts for this project.

# Change to script folder.
cd "$(dirname "$0")"

echo "Cleaning: Playground"

rm -f ./web/App.js*
rm -f ./web/Evaluator.js*
rm -fr ./web/Compiler
rm -fr ./web/Script
