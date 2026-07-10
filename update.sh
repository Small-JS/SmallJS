#!/bin/bash

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

# Ask confirmation

echo "This script updates all dependencies of Node.js projects to the latest versions."
if
	[[ ! "$1" == "-y" ]]
then
	echo "Script must be called with argument '-y' to update."
	echo "Aborting."
	exit 1
fi

# Perform updates

echo "Updating..."

./Compiler/update.sh -y
./Node/update.sh -y
./Examples/update.sh -y

echo "==== Updates successful"
echo "To update all global npm dependencies type: npm -g update"
