#!/bin/bash
# This script removes all installed / compiled / generated artifacts for this project.

# Chage to script folder.
cd "$(dirname "$0")"

echo "Cleaning: Compiler"

rm -fr ./out
