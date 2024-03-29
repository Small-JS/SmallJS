#!/bin/bash
# This script removes all installed / compiled / generated artifacts.
# Used for testing the scripts install.sh and build.sh

echo "This script will remove compiled Smalltalk and TypeScript code"
echo "and remove installed NPM dependencies (node_modules folders)."
read -p "To you want to continue? (y/N) " confirm
if
	[[ ! $confirm == [yY] ]]
then
	echo "Aborted."
	exit 1
fi

cd "$(dirname "$0")"

echo "Removing..."

rm ./Extension/smalljs-*.vsix

rm -r ./Compiler/node_modules
rm -r ./Compiler/out

rm -r ./Node/node_modules
rm -r ./Node/out

rm ./Browser/web/App.js*
rm -r ./Browser/web/Smalltalk

rm ./Examples/Benchmark/web/App.js*
rm -r ./Examples/Benchmark/web/Smalltalk

rm ./Examples/Counter/web/App.js*
rm -r ./Examples/Counter/web/Smalltalk

rm -r ./Examples/Shop/Server/node_modules
rm -r ./Examples/Shop/Server/out

rm ./Examples/Shop/Client/web/App.js*
rm -r ./Examples/Shop/Client/web/Smalltalk

rm ./Examples/Shop/ClientSpa/web/App.js*
rm -r ./Examples/Shop/ClientSpa/web/Smalltalk

rm ./Examples/Todo/web/App.js*
rm -r ./Examples/Todo/web/Smalltalk

rm ./Website/web/App.js*
