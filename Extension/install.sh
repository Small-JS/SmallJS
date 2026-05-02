#!/bin/bash
# This script packages the Visual Studio Code language extension for SmallJS into a *.vsix file.

# Exit script if a step fails
set -e
# Set working directory to script directory
cd "$(dirname "$0")"

echo "==== Extension"

npx @vscode/vsce package
code --install-extension smalljs-1.2.0.vsix

# The command to publish the extension to the VSCode market place is:
# 	npx @vscode/vsce publish minor
# This should only be done by the maintainer.
# Need to create an Azure DevOps Personal access token first.

