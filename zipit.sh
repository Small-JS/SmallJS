#!/bin/bash

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

# Zip current folder to zip file in parent folder,
# named as this current folder's base name,
# excluding some generated / intalled files.

folder=$(basename "$PWD")
zipfile="../${folder}.zip"
echo "Zipping to: "$zipfile
rm -f $zipfile
zip -r $zipfile . -x "*/node_modules/*" "*/bin/*"
