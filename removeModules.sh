#!/bin/bash

echo "This script will remove installed NPM dependencies (node_modules folders)."
read -p "To you want to continue? (y/N) " confirm
if
	[[ ! $confirm == [yY] ]]
then
	echo "Aborted."
	exit 1
fi

cd "$(dirname "$0")"

echo "Removing core modules..."

rm -fr Compiler/node_modules
rm -fr Node/node_modules

./Examples/removeModules.sh -y

echo "To reinstall modules run: ./install.sh"
