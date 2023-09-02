#!/bin/bash
cd ../Server
set -o allexport
source .env
set +o allexport
node out/App.js
read -p "Press [Enter] to exit: "
