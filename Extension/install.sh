#!/bin/bash
# This script packages the Visual Studio Code language extension for SmallJS into a *.vsix file.

# Exit script if a step fails
set -e

cd "$(dirname "$0")"

echo "==== Extension"
vsce package
code --install-extension smalljs-1.0.1.vsix
