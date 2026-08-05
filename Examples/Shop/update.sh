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

./Server/update.sh -y
