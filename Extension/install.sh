#!/bin/bash
# This script packages the Visual Studio Code language extension for SmallJS into a *.vsix file.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Extension"

# Suppress Node deprecation warnings
export NODE_NO_WARNINGS=1
../node_modules/.bin/vsce package
code --install-extension smalljs-1.0.1.vsix
