#!/bin/bash

# Exit script if a step fails
set -e
# Set working directory to script directory.
cd "$(dirname "$0")"

# Check confirmation argument '-y'

if
	[[ ! "$1" == "-y" ]]
then
	echo "Script must be called with argument '-y' to update."
	echo "Aborting."
	exit 1
fi

# Perform update

echo "==== Updating: Example AI RAG"
npx npm-check-updates -u --cooldown 7d
./install.sh
