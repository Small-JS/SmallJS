#!/bin/bash

echo "This script will remove installed npm dependencies (node_modules folders)."
if
	[[ ! "$1" == "-y" ]]
then
	echo "Script must be called with argument '-y' to update."
	echo "Aborting."
	exit 1
fi

cd "$(dirname "$0")"

echo "Removing core modules..."

rm -fr Compiler/node_modules
rm -fr Node/node_modules

./Examples/removeModules.sh -y

echo "To reinstall modules run: ./installAll.sh"
