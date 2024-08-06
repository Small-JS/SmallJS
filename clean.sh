#!/bin/bash
# This script removes all installed / compiled / generated artifacts.
# Used for testing the scripts install.sh and build.sh

echo "This script will remove all compiled Smalltalk and TypeScript code."
read -p "To you want to continue? (y/N) " confirm
if
	[[ ! $confirm == [yY] ]]
then
	echo "Aborted."
	exit 1
fi

cd "$(dirname "$0")"

echo "Removing compiled code..."

rm -fr ./Compiler/out

rm -fr ./Node/out

rm -f ./Browser/web/App.js*
rm -fr ./Browser/web/Script
rm -fr ./Browser/web/Smalltalk

rm -f ./Examples/Balls/web/App.js*
rm -fr ./Examples/Balls/web/Script
rm -fr ./Examples/Balls/web/Smalltalk

rm -f ./Examples/Benchmark/web/App.js*
rm -fr ./Examples/Benchmark/web/Script
rm -fr ./Examples/Benchmark/web/Smalltalk

rm -f ./Examples/Counter/web/App.js*
rm -fr ./Examples/Counter/web/Script
rm -fr ./Examples/Counter/web/Smalltalk

rm -fr ./Examples/Shop/Server/out

rm -f ./Examples/Shop/Client/web/App.js*
rm -fr ./Examples/Counter/web/Script
rm -fr ./Examples/Counter/web/Smalltalk

rm -f ./Examples/Shop/ClientSpa/web/App.js*
rm -fr ./Examples/Shop/ClientSpa/web/Script
rm -fr ./Examples/Shop/ClientSpa/web/Smalltalk

rm -f ./Examples/Todo/web/App.js*
rm -fr ./Examples/Todo/web/Script
rm -fr ./Examples/Todo/web/Smalltalk

rm -f ./Playground/web/App.js*
rm -f ./Playground/web/Evaluator.js*
rm -fr ./Playground/web/Compiler
rm -fr ./Playground/web/Script
rm -fr ./Playground/web/Smalltalk

rm -f ./Website/web/App.js*
rm -fr ./Website/web/Examples/Balls
rm -fr ./Website/web/Examples/Benchmark
rm -fr ./Website/web/Examples/Counter
rm -fr ./Website/web/Examples/Todo

echo "To rebuild run: ./build.sh"
