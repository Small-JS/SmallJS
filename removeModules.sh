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

echo "Removing modules..."

rm ./Extension/smalljs-*.vsix

rm -r ./Compiler/node_modules
rm -r ./Node/node_modules
rm -r ./Examples/Shop/Server/node_modules

echo "To reinstall modules run: ./install.sh"
