#!/bin/bash
# This script removes all installed / compiled / generated artifacts.
# Used for testing the scripts install.sh and build.sh

cd "$(dirname "$0")"

rm -r ./Compiler/node_modules
rm -r ./Compiler/out

rm -r ./Node/node_modules
rm -r ./Node/out

rm ./Browser/web/App.js*
rm -r ./Browser/web/Smalltalk

rm -r ./Shop/Server/node_modules
rm -r ./Shop/Server/out

rm ./Shop/Client/web/App.js*
rm -r ./Shop/Client/web/Smalltalk
