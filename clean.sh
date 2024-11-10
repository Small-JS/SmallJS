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

./Compiler/clean.sh
./Extension/clean.sh
./Browser/clean.sh
./Node/clean.sh
./Examples/Balls/clean.sh
./Examples/Benchmark/clean.sh
./Examples/Counter/clean.sh
./Examples/Electron/clean.sh
./Examples/NodeGui/clean.sh
./Examples/Pharo/Client/clean.sh
./Examples/Shop/Client/clean.sh
./Examples/Shop/ClientSpa/clean.sh
./Examples/Shop/Server/clean.sh
./Examples/Todo/clean.sh
./Examples/WebWorkers/clean.sh
./Playground/clean.sh
./Website/clean.sh

echo "To rebuild run: ./build.sh"
