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

echo "==== Globals"
cd $cwd
npx npm-check-updates -u
npm install

echo "==== Compiler"
cd $cwd/Compiler
npx npm-check-updates -u
npm install

echo "==== Node"
cd $cwd/Node
npx npm-check-updates -u
npm install

# Update examples

cd $cwd
./Examples/update.sh

# Ending messages

echo "==== Updates successful"
echo "To update all global npm dependencies type: npm -g update"
