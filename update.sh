#!/bin/bash

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

# Ask confirmation

echo "This script will update all dependencies of Node.js projects to the latest versions"
read -p "To you want to continue? (y/N) " confirm
if
	[[ ! $confirm == [yY] ]]
then
	echo "Aborted."
	exit 1
fi

# Perform updates

cwd=$(pwd)

echo "Updating..."

echo "==== Compiler"
cd $cwd/Compiler
ncu -u
npm install

echo "==== Node"
cd $cwd/Node
ncu -u
npm install

echo "==== Examples: Shop Server"
cd $cwd/Examples/Shop/Server
ncu -u
npm install

echo "==== Examples: Electron"
cd $cwd/Examples/Electron
ncu -u
npm install

echo "==== Examples: NodeGui"
cd $cwd/Examples/NodeGui
ncu -u
npm install

# Ending messages

echo "==== Updates successful"
echo "To update all global npm dependencies type: npm -g update"
