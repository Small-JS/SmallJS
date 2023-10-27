#!/bin/bash
# Start Node server.

cd "$(dirname "$0")"

set -o allexport
source .env
set +o allexport

node out/App.js

# Pause when called with -p
if [ "$1" == "-p" ]
then read -p "Press [Enter]: "
fi
