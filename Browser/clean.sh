#!/bin/bash
# This script removes all installed / compiled / generated artifacts for this project.

# Change to script folder.
cd "$(dirname "$0")"

echo "Cleaning: Browser"

rm -fr ./web/Script
