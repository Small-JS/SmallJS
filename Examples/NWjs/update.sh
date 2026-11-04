#!/bin/bash

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

# Ask confirmation

if
	[[ ! "$1" == "-y" ]]
then
	echo "Script must be called with argument '-y' to update."
	echo "Aborting."
	exit 1
fi

echo "==== Nwjs"
npx npm-check-updates -u --cooldown 7d --reject nw
# Keep the SDK flavor of NW.js, which is needed for debugging in VSCode.
npx npm-check-updates -u --cooldown 7d --filter nw --target @sdk
./install.sh
