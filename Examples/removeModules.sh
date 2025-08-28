#!/bin/bash
# Remove npm modules of examples.
# This script must be called with argument "-y" to perform removal.

if
	test "$1" != "-y"
then
	echo "Script not called with '-y', aborting."
	exit 1
fi

cd "$(dirname "$0")"

echo "Removing example modules..."

rm -fr AI/Server/node_modules
rm -fr Electron/node_modules
rm -fr NodeGui/node_modules
rm -fr NWjs/node_modules
rm -fr Shop/Server/node_modules
