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

rm -fr ./Compiler/node_modules
rm -fr ./Node/node_modules
rm -fr ./Examples/Electron/node_modules
rm -fr ./Examples/NodeGui/node_modules
rm -fr ./Examples/Shop/Server/node_modules

echo "To reinstall modules run: ./install.sh"
