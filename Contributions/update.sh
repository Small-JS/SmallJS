#!/bin/bash
# Update npm dependencies for contributions.

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

./CounterUsingMithril/update.sh -y
./ReactCounter/update.sh -y
./NodeGui/update.sh -y
