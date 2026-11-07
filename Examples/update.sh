#!/bin/bash
# This script updates the npm dependencies of the examples.
# This script must be called with argument "-y" to perform the update.

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

# Check confirmation

if
	[[ ! "$1" == "-y" ]]
then
	echo "Script must be called with argument '-y' to update."
	echo "Aborting."
	exit 1
fi

./AI/update.sh -y
./Electron/update.sh -y
./NWjs/update.sh -y
./Shop/update.sh -y
