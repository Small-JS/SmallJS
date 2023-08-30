#!/bin/bash
cd ../Server
export LOVE_PORT=3000
node out/App.js
read -p "Press [Enter] to exit: "
