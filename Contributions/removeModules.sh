#!/bin/bash
# Remove npm modules of contributions.
# This script must be called with argument "-y" to perform removal.

if
	test "$1" != "-y"
then
	echo "Script not called with '-y', aborting."
	exit 1
fi

cd "$(dirname "$0")"

echo "Removing modules for contributions..."

rm -fr CounterUsingMithril/node_modules
