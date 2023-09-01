#!/bin/bash
# Start static web server.
# To install: npm install --global http-server
echo "Current directory: "
pwd
http-server -c-1 -p 3000 web
read -p "Press [Enter] to exit: "
