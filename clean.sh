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
./Playground/clean.sh
./Website/clean.sh
./Examples/clean.sh

echo "To rebuild run: ./buildAll.sh"
